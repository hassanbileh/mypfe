import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/widgets/components/gradient_button.dart';

typedef ShowCalendar = void Function();
typedef Swap = void Function();
typedef Search = void Function()?;
typedef CallPassengersNum = void Function()?;

class SearchTicket extends StatefulWidget {
  const SearchTicket({
    super.key,
    required this.selectedFromStation,
    required this.selectedToStation,
    required this.showCalendar,
    required this.swap,
    required this.search,
    required this.nbrPassengers,
    required this.selectedDate,
  });

  final ShowCalendar showCalendar;
  final Swap swap;
  final Search search;
  final CallPassengersNum nbrPassengers;
  final String? selectedDate;
  final String selectedFromStation;
  final String selectedToStation;

  @override
  State<SearchTicket> createState() => _SearchTicketState();
}

class _SearchTicketState extends State<SearchTicket> {
  late final FirebaseCloudStationStorage _stationService;
  String? _selectedFromStation;
  String? _selectedToStation;

  @override
  void initState() {
    _stationService = FirebaseCloudStationStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10.0),
            child: StreamBuilder(
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

                  return Container(
                    child: Column(
                      children: [
                        //DEPART
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.tram_outlined,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),

                            // depart
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.8,
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
                                hint: const Text("station de départ"),
                              ),
                            ),
                          ],
                        ),
                        //DESTINATION
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_sharp,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.8,
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
                                hint: const Text("station d'arrivée"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          //date & passengers
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.showCalendar,
                  child: Container(
                    height: 50,
                    width: 130,
                    margin: const EdgeInsets.only(left: 10.0, top: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text((widget.selectedDate == null)
                            ? 'Date'
                            : widget.selectedDate!),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: widget.nbrPassengers,
                  child: Container(
                    height: 50,
                    width: 130,
                    margin:
                        const EdgeInsets.only(left: 10.0, top: 5.0, right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(Icons.person),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('(1) Adulte'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: GradientButton(
              buttonText: 'Rechercher',
              onPressed: widget.search,
              height: 50,
              width: MediaQuery.sizeOf(context).width * 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
