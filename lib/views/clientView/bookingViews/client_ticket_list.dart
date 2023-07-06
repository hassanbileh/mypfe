import 'package:flutter/material.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/widgets/classe/class_ticket.dart';

import '../../../models/classe.dart';
import '../../../models/ticket.dart';

typedef TicketCallBack = void Function(CloudTicket ticket, CloudClasse classe);

class ClientTicketList extends StatelessWidget {
  final Iterable<CloudTicket> tickets;
  final TicketCallBack onBook;
  const ClientTicketList({
    super.key,
    required this.tickets,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // prototypeItem: const TicketItem(),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets.elementAt(index);
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Text(
                              ticket.destination,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              ticket.heureArrive,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                StreamBuilder(
                  stream: FirebaseCloudClasseStorage()
                      .getClassesByTrainNum(trainNum: ticket.trainNum),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.done:
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allClasses =
                              snapshot.data as Iterable<CloudClasse>;
                          final List<Widget> classes = [];
                          for (var i = 0; i < allClasses.length; i++) {
                            if (allClasses.elementAt(i).places <= 0) {
                              classes.add(
                                ClassOnTicket(
                                  className: allClasses.elementAt(i).nom,
                                  height: 48,
                                  width: 110,
                                  isAvailable: false,
                                  places: allClasses.elementAt(i).places,
                                ),
                              );
                            } else {
                              classes.add(GestureDetector(
                                onTap: () =>
                                    onBook(ticket, allClasses.elementAt(i)),
                                child: ClassOnTicket(
                                  className: allClasses.elementAt(i).nom,
                                  height: 48,
                                  width: 100,
                                  isAvailable: true,
                                  places: allClasses.elementAt(i).places,
                                ),
                              ));
                            }
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: classes,
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
            ),
          ),
        );
      },
    );
  }
}
