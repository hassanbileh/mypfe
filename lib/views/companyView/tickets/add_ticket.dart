import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';

final formatter = DateFormat.yMMMd();

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  String get compagnyEmail => AuthService.firebase().currentUser!.email;
  late final FirebaseCloudUserStorage _userService;
  late final FirebaseCloudTrainStorage _trainService;
  late final FirebaseCloudStationStorage _stationService;
  late final FirebaseCloudTicketStorage _ticketService;

  String? _selectedDate;
  String? _selectedDepartureTime;
  String? _selectedArrivalTime;
  String? _selectedTrain;
  String? _selectedFromStation;
  String? _selectedToStation;
  String get compagnieEmail => AuthService.firebase().currentUser!.email;
  bool? _status;

  @override
  void initState() {
    _userService = FirebaseCloudUserStorage();
    _ticketService = FirebaseCloudTicketStorage();
    _stationService = FirebaseCloudStationStorage();
    _trainService = FirebaseCloudTrainStorage();
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
      _selectedDate = formatter.format(pickedDate!);
    });
  }

  void _afficheDepartureHorloge() async {
    final time = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    setState(() {
      final localisations = MaterialLocalizations.of(context);
      final formattedDepartureTime = localisations.formatTimeOfDay(pickedTime!,
          alwaysUse24HourFormat: true);
      _selectedDepartureTime = formattedDepartureTime;
    });
  }

  void _afficheArrivalHorloge() async {
    final time = TimeOfDay.now();

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    setState(() {
      final localisations = MaterialLocalizations.of(context);
      final formattedDepartureTime = localisations.formatTimeOfDay(pickedTime!,
          alwaysUse24HourFormat: true);
      _selectedArrivalTime = formattedDepartureTime;
    });
  }

  void _submitTicketData() async {
    try {
      if (_selectedDate == null ||
          _selectedFromStation == null ||
          _selectedToStation == null ||
          _selectedTrain == null ||
          _selectedDepartureTime == null ||
          _selectedArrivalTime == null) {
        return showErrorDialog(context, 'Veuillez remplir tous les champs');
      }
      final company = await _userService.getUserName(email: compagnieEmail);
      await _ticketService.createNewTicket(
        company: company!,
        trainNum: _selectedTrain!,
        date: _selectedDate!,
        heureDepart: _selectedDepartureTime!,
        heureArrive: _selectedArrivalTime!,
        status: _status!,
        depart: _selectedFromStation!,
        destination: _selectedToStation!,
        compagnieEmail: compagnieEmail,
      );
      Navigator.of(context).pop();
    } catch (e) {
      throw CouldNotCreateTicketException();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Ajouter un Ticket",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.confirmation_num_rounded,
                size: 50,
              ),
            ],
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
                  Text((_selectedDate == null) ? 'Date' : _selectedDate!),
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
                      : _selectedDepartureTime!),
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
                      : _selectedArrivalTime!),
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

          //Apply Availability
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Disponibility :",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 40,
                width: 100,
                child: LiteRollingSwitch(
                  textSize: 16,
                  textOnColor: Colors.white,
                  iconOff: Icons.alarm_off_outlined,
                  onDoubleTap: () {},
                  onTap: () {},
                  onChanged: (bool status) {
                    if (!status) {
                      setState(() {
                        _status = false;
                      });
                    } else {
                      setState(() {
                        _status = true;
                      });
                    }
                  },
                  onSwipe: () {},
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Confirm
          Container(
            height: 40,
            width: 180,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
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
              onPressed: () => _submitTicketData(),
            ),
          ),
        ],
      ),
    );
  }
}
