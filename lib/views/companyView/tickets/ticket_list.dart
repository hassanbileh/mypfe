import 'package:flutter/material.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/utilities/dialogs/delete_dialog.dart';
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
  });
  final Iterable<CloudTicket> tickets;
  final TicketCallBack onModify;
  final TicketCallBack onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // prototypeItem: const TicketItem(),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets.elementAt(index);
        return Dismissible(
          key: ValueKey(tickets.elementAt(index)),
          background: Container(
            color: Theme.of(context).colorScheme.error,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Supprimer',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          onDismissed: (direction) async {
            final shouldDelete = await showDeleteDialog(context);
            if (shouldDelete) {
              onDelete(ticket);
            }
          },
          child: GestureDetector(
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
                                  classes.add(ClassOnTicket(
                                    className: allClasses.elementAt(i).nom,
                                    height: 50,
                                    width: 110,
                                    isAvailable: false,
                                    places: allClasses.elementAt(i).places,
                                    prixClasse:
                                        allClasses.elementAt(i).prixClasse,
                                  ));
                                } else {
                                  classes.add(ClassOnTicket(
                                    className: allClasses.elementAt(i).nom,
                                    height: 50,
                                    width: 100,
                                    isAvailable: true,
                                    places: allClasses.elementAt(i).places,
                                    prixClasse:
                                        allClasses.elementAt(i).prixClasse,
                                  ));
                                }
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                    const SizedBox(height: 10.0,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
