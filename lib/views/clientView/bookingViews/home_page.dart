import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';

import '../../../services/cloud/storage/station_storage.dart';

final formatter = DateFormat.yMMMd();

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  late final FirebaseCloudStationStorage _stationService;
  late final FirebaseCloudTrainStorage _trainService;
  late final TextEditingController _depart;
  late final TextEditingController _arrivee;
  String? _selectedDate;
  String? _selectedFromStation;
  String? _selectedToStation;

  @override
  void initState() {
    _stationService = FirebaseCloudStationStorage();
    _trainService = FirebaseCloudTrainStorage();
    _depart = TextEditingController();
    _arrivee = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                ),
              ],
            ),
            Container(
                height: 250,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Où désirez-vous voyager ?',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    StreamBuilder(
                      stream: _stationService.getAllStations(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text("loading");
                        } else {
                          final allStations =
                              snapshot.data as Iterable<CloudStation>;

                          final List<String> stations = [];
                          for (var i = 0; i < allStations.length; i++) {
                            stations.add(
                              allStations.elementAt(i).nom,
                            );
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              const Text(
                                "Départ :",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 20,
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
                                  hint: const Text(
                                      "Selectionner une station de départ"),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: _stationService.getAllStations(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text("loading");
                        } else {
                          final allStations =
                              snapshot.data as Iterable<CloudStation>;

                          final List<String> stations = [];
                          for (var i = 0; i < allStations.length; i++) {
                            stations.add(
                              allStations.elementAt(i).nom,
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: Color.fromARGB(255, 74, 44, 156),
                                ),
                                const Text(
                                  "Destination :",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
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
                                    hint: const Text(
                                        "Selectionner une station de départ"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),

                    // Choose date & continue
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => _afficheCalendrier(),
                              icon: const Icon(
                                Icons.calendar_month,
                                size: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              (_selectedDate == null)
                                  ? 'Date (toucher le calendrier)'
                                  : _selectedDate!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              height: 35,
                              width: 100,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 113, 68, 239),
                                    Color.fromARGB(255, 183, 128, 255),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      ticketsResultsRoute,
                                      arguments: [_selectedFromStation, _selectedToStation, _selectedDate]);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
