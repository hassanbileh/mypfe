import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mypfe/models/station.dart';

import '../../models/train.dart';

typedef StreamCallBack = Stream<Iterable<Object>>?;
typedef BuilderCallBack = Widget Function(
    BuildContext context, AsyncSnapshot<Iterable<Object>> snapshot);
typedef OnChangeCallBack = void Function(String? value)?;

typedef AvailabilityCallBack = dynamic Function(bool value);

typedef CalendarCallBack = void Function()?;
typedef TimeCallBack = void Function()?;
typedef SubmitCallBack = void Function()?;

class FormTicket extends StatelessWidget {
  final StreamCallBack stationStream;
  final StreamCallBack trainStream;

  final OnChangeCallBack onChangeFromStation;
  final OnChangeCallBack onChangeToStation;

  final String? fromStationValue;
  final String? toStationValue;

  final OnChangeCallBack onChangeTrain;
  final String? trainValue;

  final String? selectedDate;
  final CalendarCallBack onPressed;
  final String? selectedDepartureTime;
  final TimeCallBack onPressedDepartureTime;
  final String? selectedArrivalTime;
  final TimeCallBack onPressedArrivalTime;
  final AvailabilityCallBack onPressedSwitch;
  final SubmitCallBack submitData;

  const FormTicket({
    super.key,
    required this.stationStream,
    required this.onChangeFromStation,
    required this.fromStationValue,
    required this.onChangeToStation,
    required this.trainStream,
    required this.onChangeTrain,
    required this.trainValue,
    required this.selectedDate,
    required this.onPressed,
    required this.selectedDepartureTime,
    required this.onPressedDepartureTime,
    required this.selectedArrivalTime,
    required this.onPressedArrivalTime,
    required this.onPressedSwitch,
    required this.submitData,
    required this.toStationValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un Ticket"),
      ),
      body: Container(
        height: 600,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Title
            const Icon(
              Icons.confirmation_num_rounded,
              size: 50,
            ),
            const SizedBox(
              height: 40,
            ),

            //From this Station
            StreamBuilder(
              stream: stationStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("loading");
                } else {
                  final allItems = snapshot.data as Iterable<CloudStation>;
                  final List<String> stations = [];
                  for (var i = 0; i < allItems.length; i++) {
                    stations.add(
                      allItems.elementAt(i).nom,
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
                          onChanged: onChangeFromStation,
                          value: fromStationValue,
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
              stream: stationStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("loading");
                } else {
                  final allItems = snapshot.data as Iterable<CloudStation>;
                  final List<String> stations = [];
                  for (var i = 0; i < allItems.length; i++) {
                    stations.add(
                      allItems.elementAt(i).nom,
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
                          onChanged: onChangeToStation,
                          value: toStationValue,
                          hint: const Text("Selectionner une station"),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            //Train
            StreamBuilder(
              stream: trainStream,
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
                          onChanged: onChangeTrain,
                          value: trainValue,
                          hint: const Text("Selectionner un train"),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            //Choose date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Selectionner une date :",
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text((selectedDate == null) ? 'Date' : selectedDate!),
                    IconButton(
                      onPressed: onPressed,
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
                    Text((selectedDepartureTime == null)
                        ? 'Heure'
                        : selectedDepartureTime!),
                    IconButton(
                      onPressed: onPressedDepartureTime,
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
                    Text((selectedArrivalTime == null)
                        ? 'Heure'
                        : selectedArrivalTime!),
                    IconButton(
                      onPressed: onPressedArrivalTime,
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
                    onChanged: onPressedSwitch,
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
                onPressed: submitData,
                child: const Text(
                  'Confirmer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
