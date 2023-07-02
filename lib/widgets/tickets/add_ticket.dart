import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  String get compagnyEmail => AuthService.firebase().currentUser!.email;
  String? _selectedTrain;
  String? _selectedFromStation;
  String? _selectedToStation;
  late final FirebaseCloudTrainStorage _trainService;
  final _stationService = FirebaseCloudStationStorage();
  String get compagnieEmail => AuthService.firebase().currentUser!.email;
  late final TextEditingController depart;
  late final TextEditingController destination;
  late final int jour;
  late final int heureDepart;
  late final int heureArrive;
  late final bool status;

  @override
  void initState() {
    _trainService = FirebaseCloudTrainStorage();

    depart = TextEditingController();
    destination = TextEditingController();
    jour = DateTime.now().day;
    heureDepart = DateTime.now().hour;
    heureArrive = DateTime.now().hour;
    status = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Title
          const Text(
            "Ajouter un ticket",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          // Icon
          const Icon(
            Icons.confirmation_num_rounded,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          // From this station
          StreamBuilder(
            stream: _stationService.getAllStations(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("loading");
              } else {
                final allStations = snapshot.data as Iterable<CloudStation>;

                final List<String> stations = [];
                for (var i = 0; i < allStations.length; i++) {
                  stations.add(
                    allStations.elementAt(i).nom,
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Départ :",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: DropdownButton(
                        elevation: 5,
                        isExpanded: true,
                        items: stations
                            .map(
                              (String station) => DropdownMenuItem(
                                value: station,
                                child: Text(station),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              setState(() {
                                _selectedFromStation = value;
                              });
                            } else {
                              return;
                            }
                          });
                        },
                        value: _selectedFromStation,
                        hint: const Text("Selectionner une station"),
                      ),
                    ),
                  ],
                );
              }
            },
          ),

          // TO this station
          StreamBuilder(
            stream: _stationService.getAllStations(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("loading");
              } else {
                final allStations = snapshot.data as Iterable<CloudStation>;

                final List<String> stations = [];
                for (var i = 0; i < allStations.length; i++) {
                  stations.add(
                    allStations.elementAt(i).nom,
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Destination :",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: DropdownButton(
                        elevation: 5,
                        isExpanded: true,
                        items: stations
                            .map(
                              (String station) => DropdownMenuItem(
                                value: station,
                                child: Text(station),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              setState(() {
                                _selectedToStation = value;
                              });
                            } else {
                              return;
                            }
                          });
                        },
                        value: _selectedToStation,
                        hint: const Text("Selectionner une station"),
                      ),
                    ),
                  ],
                );
              }
            },
          ),

          // Choose a train
          StreamBuilder(
            stream: _trainService.getTrainsByCompany(compagnieEmail: compagnieEmail),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("loading");
              } else {
                final allTrains = snapshot.data as Iterable<CloudTrain>;

                final List<String> trains = [];
                for (var i = 0; i < allTrains.length; i++) {
                  trains.add(
                    allTrains.elementAt(i).numero,
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Train :",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: DropdownButton(
                        elevation: 5,
                        isExpanded: true,
                        items: trains
                            .map(
                              (String train) => DropdownMenuItem(
                                value: train,
                                child: Text(train),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              setState(() {
                                _selectedTrain = value;
                              });
                            } else {
                              return;
                            }
                          });
                        },
                        value: _selectedTrain,
                        hint: const Text("Selectionner un train"),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          
              
        ],
      ),
    );
  }
}
