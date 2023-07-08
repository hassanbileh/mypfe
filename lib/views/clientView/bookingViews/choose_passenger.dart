import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/passager.dart';
import 'package:mypfe/models/reservation.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/services/cloud/storage/reservation_storage.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/views/clientView/bookingViews/passenger_list.dart';

import '../../../services/cloud/storage/passager_storage.dart';

class ChoosePassenger extends StatefulWidget {
  const ChoosePassenger({super.key});

  @override
  State<ChoosePassenger> createState() => _ChoosePassengerState();
}

class _ChoosePassengerState extends State<ChoosePassenger> {
  String get client => AuthService.firebase().currentUser!.email;
  late final FirebaseCloudPassagerStorage _passengerService;
  bool checkValue = false;
  List<CloudPassager> localPassagers = [];
  int nbrPassagers = 0;

  @override
  void initState() {
    _passengerService = FirebaseCloudPassagerStorage();
    super.initState();
  }
  
  void updateLocalList(CloudPassager p) {
    setState(() {
      localPassagers.add(p);
      nbrPassagers += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final forPassenger = context.getArguments<CloudReservation>();
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        bottom: PreferredSize(
            // ignore: sort_child_properties_last
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 130,
                  color: Colors.deepPurple,
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: FutureBuilder(
                      future: FirebaseCloudTicketStorage()
                          .getTicket(documentId: forPassenger!.ticketId),
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text("-"),
                                            ),
                                            Text(
                                              ticket.heureArrive,
                                              style: TextStyle(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                          ticket.destination,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        future: FirebaseCloudClasseStorage()
                                            .getClasse(
                                                documentId: forPassenger.classe),
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.done:
                                            case ConnectionState.active:
                                            case ConnectionState.waiting:
                                              if (snapshot.hasData) {
                                                final theClasse = snapshot.data
                                                    as CloudClasse;
                                                return Row(
                                                  children: [
                                                    Text(
                                                      theClasse.nom,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors
                                                              .deepPurple[500]),
                                                    ),
                                                    SizedBox(width: 20,),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.monetization_on_outlined),
                                                          Text(
                                                            theClasse.prixClasse
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                fontSize: 16, color: Colors.deepPurple[500],),
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
            ),
            preferredSize: Size.fromHeight(150)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(choosePassengerRoute, arguments: forPassenger);
            },
            icon: Icon(Icons.restart_alt_rounded),
          ),
        ],
        leading: IconButton(
            onPressed: () async {
              final booking = context.getArguments<CloudReservation>();
              await FirebaseCloudReservationStorage()
                  .deleteReservation(documentId: booking!.documentId);
              Navigator.of(context).pushNamed(clientHomePageRoute);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Select Passager',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
          ),
        ),
        backgroundColor: Colors.deepPurple[500],
        // bottom: PreferredSize(
        //     child: Card(
        //       child: Column(
        //         children: [
        //            Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               Text(
        //                 "Jul 10, 2023",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.w600),
        //               ),
        //               Text(
        //                 "-",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.w600),
        //               ),
        //               Text(
        //                 "08:00 - 20:00",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.w600),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //     preferredSize: Size(300, 120)),
      ),
      
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _passengerService.getAllPassengers(client: client),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final allPassengers =
                      snapshot.data as Iterable<CloudPassager>;
                  List<Widget> passengers = [];
                  for (var passenger in allPassengers) {
                    
                    passengers.add(Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: ListTile(
                        leading: Checkbox(
                          value: checkValue,
                          checkColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              nbrPassagers += 1;
                              checkValue = value as bool;
                            });
                          },
                        ),
                        title: Text(passenger.nom),
                        subtitle: Row(
                          children: [
                            Text(passenger.age.toString()),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("|"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(passenger.nationalite!)
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              setState(() {
                                localPassagers.remove(passenger);
                              });
                              await FirebaseCloudPassagerStorage()
                                  .deletePassenger(
                                      documentId: passenger.documentId);
                            },
                            icon: const Icon(Icons.delete)),
                      ),
                    ));
                    () => updateLocalList(passenger);
                  }
                  return Column(
                    children: [
                      //Add Passenger
                      Container(
                        height: 80,
                        margin: const EdgeInsets.all(30),
                        color: Colors.white.withOpacity(0.7),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 113, 68, 239),
                                    Color.fromARGB(255, 183, 128, 255),
                                  ],
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        addPassengerRoute,
                                        arguments: forPassenger!);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Ajouter un passager",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Passagers Recents",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var passager in passengers) passager,
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }

              default:
                return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Container(
          height: 60,
          width: 250,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[
                Color.fromARGB(255, 113, 68, 239),
                Color.fromARGB(255, 183, 128, 255),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: OutlinedButton(
            onPressed: () async {
              if (!checkValue && localPassagers.isEmpty) {
                return await showErrorDialog(
                    context, "Veuillez ajouter au moins un passager");
              } else if (!checkValue){
                return await showErrorDialog(
                    context, "Veuillez selectionner au moins un passager");
              }else{
                final nbrPassagers = localPassagers.length;
                setState(() {
                  print(localPassagers.length);
                });

                Navigator.of(context).pushNamed(paiementViewRoute, arguments: [forPassenger, nbrPassagers]);
              }
              
            },
            child: const Text(
              "Payer",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
