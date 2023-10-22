import 'package:flutter/material.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';

import '../../services/cloud/storage/classe_storage.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({
    super.key,
    required this.ticketService,
    required this.classeService, 
    required this.context,
    required this.ticketId,
    required this.classeId,
  });
  final FirebaseCloudTicketStorage ticketService;
  final FirebaseCloudClasseStorage classeService;
  final String ticketId;
  final String classeId;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 130,
          color: Colors.deepPurple,
          child: Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: FutureBuilder(
              future: ticketService.getTicket(documentId: ticketId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.done:
                  case ConnectionState.waiting:
                    if (snapshot.hasData) {
                      final ticket = snapshot.data as CloudTicket;
                      return Column(
                        children: [
                          Row(
                            children: [
                              //Date voyage
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ticket.jour,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.8,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),

                              //Heure voyage
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      ticket.heureDepart,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("-"),
                                    ),
                                    Text(
                                      ticket.heureArrive,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Station de depart
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                child: Text(
                                  ticket.depart,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.8,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  ticket.destination,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  ticket.trainNum,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.deepPurple[500]),
                                ),
                              ),
                              FutureBuilder(
                                future: classeService.getClasse(
                                    documentId: classeId),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      if (snapshot.hasData) {
                                        final theClasse =
                                            snapshot.data as CloudClasse;
                                        return Row(
                                          children: [
                                            Text(
                                              theClasse.nom,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color:
                                                      Colors.deepPurple[500]),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Icon(Icons
                                                      .monetization_on_outlined),
                                                  Text(
                                                    theClasse.prixClasse
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Colors
                                                          .deepPurple[500],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    default:
                                      return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }

                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
