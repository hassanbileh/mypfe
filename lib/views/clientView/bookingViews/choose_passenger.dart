import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/passager.dart';
import 'package:mypfe/models/reservation.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/services/cloud/storage/reservation_storage.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/widgets/tickets/ticket_item.dart';

import '../../../services/cloud/storage/passager_storage.dart';

class ChoosePassenger extends StatefulWidget {
  const ChoosePassenger({super.key});

  @override
  State<ChoosePassenger> createState() => _ChoosePassengerState();
}

class _ChoosePassengerState extends State<ChoosePassenger> {
  String get client => AuthService.firebase().currentUser!.email;
  late final FirebaseCloudPassagerStorage _passengerService;
  late final FirebaseCloudTicketStorage _ticketService;
  late final FirebaseCloudClasseStorage _classeService;
  bool checkValue = true;
  List<CloudPassager> localPassagers = [];
  int nbrPassagers = 0;

  @override
  void initState() {
    _passengerService = FirebaseCloudPassagerStorage();
    _ticketService = FirebaseCloudTicketStorage();
    _classeService = FirebaseCloudClasseStorage();
    super.initState();
  }

  void updateLocalList(CloudPassager p) {
    setState(() {
      localPassagers.add(p);
      nbrPassagers += 1;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forPassenger = context.getArguments<CloudReservation>();
    final ticket = forPassenger!.ticketId;
    final classe = forPassenger.classe;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: TicketItem(
            ticketService: _ticketService,
            classeService: _classeService,
            context: context,
            ticketId: ticket,
            classeId: classe,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(choosePassengerRoute, arguments: forPassenger);
            },
            icon: const Icon(
              Icons.restart_alt_rounded,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () async {
              final booking = context.getArguments<CloudReservation>();
              await FirebaseCloudReservationStorage()
                  .deleteReservation(documentId: booking!.documentId);
              Navigator.of(context).pushNamed(mainClientRoute);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: const Text(
          'Select Passager',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
          ),
        ),
        backgroundColor: Colors.deepPurple[500],
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
                      margin: const EdgeInsets.all(8.0),
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
                                        arguments: forPassenger);
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
                  return const CircularProgressIndicator();
                }

              default:
                return const CircularProgressIndicator();
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
              } else if (!checkValue) {
                return await showErrorDialog(
                    context, "Veuillez selectionner au moins un passager");
              } else {
                final nbrPassagers = localPassagers.length;
                setState(() {
                  print(localPassagers.length);
                });

                Navigator.of(context).pushNamed(paiementViewRoute,
                    arguments: [forPassenger, nbrPassagers]);
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
