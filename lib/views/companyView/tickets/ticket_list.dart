import 'package:flutter/material.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/views/companyView/tickets/ticket_item.dart';
import 'package:mypfe/widgets/classe/class_ticket.dart';

typedef TicketCallBack = void Function(CloudTicket ticket);
typedef ClassStreamCallBack = Stream<Iterable<CloudClasse>>?;
typedef ClassBuilderCallBack = Widget Function(
    BuildContext context, AsyncSnapshot<Iterable<CloudClasse>> snapshot);

class TicketList extends StatelessWidget {
  const TicketList({
    super.key,
    required this.tickets,
    required this.onModify,
    required this.onDelete,
    required this.classStream,
  });
  final Iterable<CloudTicket> tickets;
  final TicketCallBack onModify;
  final TicketCallBack onDelete;
  final ClassStreamCallBack classStream;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      prototypeItem: const TicketItem(),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets.elementAt(index);
        return GestureDetector(
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
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              ticket.depart,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
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
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                ticket.heureArrive,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                    stream: classStream,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.done:
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            final allClasses =
                                snapshot.data as Iterable<CloudClasse>;
                            return ListView.builder(
                              itemCount: allClasses.length,
                              itemBuilder: (context, index) {
                                if (allClasses.elementAt(index).places <= 0) {
                                  return ClassOnTicket(
                                    className: allClasses.elementAt(index).nom,
                                    height: 40,
                                    width: 80,
                                    isAvailable: false,
                                  );
                                } else {
                                  return ClassOnTicket(
                                    className: allClasses.elementAt(index).nom,
                                    height: 40,
                                    width: 80,
                                    isAvailable: true,
                                  );
                                }
                              },
                            );
                          }
                        default:
                          return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
