import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/views/clientView/bookingViews/ticket_list.dart';

class TicketsResults extends StatefulWidget {
  const TicketsResults({super.key});

  @override
  State<TicketsResults> createState() => _TicketsResultsState();
}

class _TicketsResultsState extends State<TicketsResults> {
  late final FirebaseCloudTicketStorage _ticketService;

  @override
  void initState() {
    _ticketService = FirebaseCloudTicketStorage();
    super.initState();
  }

  Stream<Iterable<CloudTicket>> fetchTickets(BuildContext context) {
    try {
      final queries = context.getArguments<List<String?>>()!;
      final tickets = _ticketService.getTicketByStationsAndDate(
          depart: queries[0]!,
          destination: queries[1]!,
          date: queries[2]!);
      return tickets;
    } catch (e) {
      throw CouldNotReadTicketException();
    }
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
                return const Text("Aucun Ticket trouvé pour ce trajet");
              } else {
                final tickets = snapshot.data as Iterable<CloudTicket>;
                return ClientTicketList(tickets: tickets, onModify: (_){});
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
