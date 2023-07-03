import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMd();

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  String get compagnyEmail => AuthService.firebase().currentUser!.email;
  DateTime? _selectedDate;
  TimeOfDay? _selectedDepartureTime;
  TimeOfDay? _selectedArrivalTime;
  String? _selectedTrain;
  String? _selectedFromStation;
  String? _selectedToStation;
  late final FirebaseCloudTrainStorage _trainService;
  final _stationService = FirebaseCloudStationStorage();
  String get compagnieEmail => AuthService.firebase().currentUser!.email;
  late final bool status;

  @override
  void initState() {
    _trainService = FirebaseCloudTrainStorage();
    status = true;
    super.initState();
  }

  void _afficheCalendrier() async {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, now.day + 3);
    final last = DateTime(now.year, now.month + 1, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: first,
      firstDate: first,
      lastDate: last,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _afficheDepartureHorloge() async {
    final time = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    setState(() {
      _selectedDepartureTime = pickedTime!;
    });
  }

  void _afficheArrivalHorloge() async {
    final time = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    setState(() {
      _selectedArrivalTime = pickedTime!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final depHours = _selectedDepartureTime?.hour.toString().padLeft(2, '0');
    final depMinutes =
        _selectedDepartureTime?.minute.toString().padLeft(2, '0');
    final arrHours = _selectedArrivalTime?.hour.toString().padLeft(2, '0');
    final arrMinutes = _selectedArrivalTime?.minute.toString().padLeft(2, '0');
    return Container(
      height: 600,
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
            height: 40,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            stream: _trainService.getTrainsByCompany(
                compagnieEmail: compagnieEmail),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

          // Select Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Selectionner une date :",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text((_selectedDate == null)
                      ? 'Date'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: () => _afficheCalendrier(),
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Select Departure Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "L'heure de départ :",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text((_selectedDepartureTime == null)
                      ? 'Heure'
                      : '$depHours:$depMinutes'),
                  IconButton(
                    onPressed: _afficheDepartureHorloge,
                    icon: const Icon(
                      Icons.timer,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //Select Arrival Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "L'heure d'arrivée :",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text((_selectedArrivalTime == null)
                      ? 'Heure'
                      : '$arrHours:$arrMinutes'),
                  IconButton(
                    onPressed: () => _afficheArrivalHorloge(),
                    icon: const Icon(
                      Icons.timer,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30,),
          // Confirm
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 113, 68, 239),
                  Color.fromARGB(255, 183, 128, 255),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: OutlinedButton(
              child: const Text(
                'Confirmer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
