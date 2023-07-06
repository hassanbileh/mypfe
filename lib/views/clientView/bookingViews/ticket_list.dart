import 'package:flutter/material.dart';

import '../../../models/ticket.dart';

typedef TicketCallBack = void Function(CloudTicket ticket);

class ClientTicketList extends StatelessWidget {
  final Iterable<CloudTicket> tickets;
  final TicketCallBack onModify;
  const ClientTicketList({
    super.key,
    required this.tickets,
    required this.onModify,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // prototypeItem: const TicketItem(),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets.elementAt(index);
        return GestureDetector(
          onTap: () {
            onModify(ticket);
          },
          child: Card(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              ticket.depart,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
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
                                    fontWeight: FontWeight.w500),
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
          ),
        );
      },
    );
  }
}
