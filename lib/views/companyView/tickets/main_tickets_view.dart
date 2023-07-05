import 'package:flutter/material.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/views/companyView/tickets/add_ticket.dart';

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

  void _startAddNewTicket(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: ctx,
      builder: (_) {
        return const AddTicket();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white60,
        appBar: null,
        body: StreamBuilder(
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
                  final allTickets = snapshot.data as Iterable<CloudTicket>;

                  return ListView.builder(
                    // prototypeItem: const TicketItem(),
                    itemCount: allTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = allTickets.elementAt(index);
                      return Card(
                        elevation: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 250, 250, 250),
                                Color.fromARGB(255, 222, 203, 248),
                              ],
                              begin: Alignment(0, -1),
                              end: Alignment(5, 1),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //Company name
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ticket.company,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.deepPurple[400]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          ticket.trainNum,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              //Departure/Arrival Stations
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          ticket.heureDepart,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          ticket.depart,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Expanded(
                                      child: Divider(
                                        thickness: 0.8,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            ticket.destination,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            ticket.heureArrive,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                 
                              
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _startAddNewTicket(context);
          },
          child: const Icon(Icons.add),
        ));
  }
}
