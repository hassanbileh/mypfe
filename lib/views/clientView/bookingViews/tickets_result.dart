import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/reservation.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/reservation_storage.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/views/clientView/bookingViews/client_ticket_list.dart';

class TicketsResults extends StatefulWidget {
  const TicketsResults({super.key});

  @override
  State<TicketsResults> createState() => _TicketsResultsState();
}

class _TicketsResultsState extends State<TicketsResults> {
  late final FirebaseCloudTicketStorage _ticketService;
  late final FirebaseCloudReservationStorage _resservationService;
  String get userEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _ticketService = FirebaseCloudTicketStorage();
    _resservationService = FirebaseCloudReservationStorage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Display Classes
  Stream<Iterable<CloudTicket>> fetchTickets(BuildContext context) {
    try {
      final queries = context.getArguments<List<String?>>()!;
      final tickets = _ticketService.getTicketByStationsAndDate(
          depart: queries[0]!, destination: queries[1]!, date: queries[2]!);
          
      return tickets;
    } catch (e) {
      throw CouldNotReadTicketException();
    }
  }

  Future<CloudReservation?> _book(
      CloudTicket ticket, CloudClasse classe) async {
    final newBooking = await _resservationService.createNewReservation(
      ticket: ticket.documentId,
      classe: classe.documentId,
      client: userEmail,
    );
    Navigator.of(context).pushNamed(choosePassengerRoute, arguments: newBooking);
    return newBooking;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Tickets',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.deepPurple[500],
      ),
      body: StreamBuilder(
        stream: fetchTickets(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
            case ConnectionState.done:
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Aucun ticket trouvé !",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Text(
                        "Note: Selectionner une autre date.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                          height: 500,
                          width: 150,
                          child: Image.asset("assets/images/waiting.png")),
                    ],
                  ),
                );
              } else {
                final tickets = snapshot.data as Iterable<CloudTicket>;
                return ClientTicketList(
                  tickets: tickets,
                  onBook: (t, c) => _book(t, c),
                );
              }

            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
