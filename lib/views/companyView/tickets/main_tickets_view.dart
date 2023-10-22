import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/views/companyView/tickets/ticket_list.dart';

class MainTicketView extends StatefulWidget {
  const MainTicketView({super.key});

  @override
  State<MainTicketView> createState() => _MainTicketViewState();
}

class _MainTicketViewState extends State<MainTicketView> {
  String get compagnyEmail => AuthService.firebase().currentUser!.email;
  late final FirebaseCloudTicketStorage _ticketService;

  @override
  void initState() {
    _ticketService = FirebaseCloudTicketStorage();
    super.initState();
  }

  // void _startAddNewTicket(BuildContext ctx) {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.white,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     context: ctx,
  //     builder: (_) {
  //       return const AddTicket();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white60,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Tickets recents',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder(
                stream: _ticketService.getAllTicketsByCompanyEmail(
                    companyEmail: compagnyEmail),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          backgroundColor: Colors.deepPurple[500],
                        );
                      } else {
                        final allTickets =
                            snapshot.data as Iterable<CloudTicket>;

                        return TicketList(
                          tickets: allTickets,
                          onModify: (ticket) {
                            Navigator.of(context).pushNamed(
                                createOrUpdateTicketRoute,
                                arguments: ticket);
                          },
                          onDelete: (CloudTicket ticket) async {
                            await _ticketService.deleteTicket(
                                documentId: ticket.documentId);
                          },
                        );
                      }
                    default:
                      return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              createOrUpdateTicketRoute,
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
