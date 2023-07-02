import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  String _selectedCategory = 'Select a station';
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

  // Iterable<CloudStation> getAllStations(BuildContext ctx){
  //   StreamBuilder(
  //     stream: _stationService.getAllStations(),
  //     builder: (ctx, snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.waiting:
  //         case ConnectionState.active:
  //           if(snapshot.hasData){
  //             final allStations = snapshot.data as Iterable<CloudStation>;
  //             return allStations;
  //           }
            
  //           break;
  //         default:
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Ajouter un ticket",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          const Icon(
            Icons.confirmation_num_rounded,
            size: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text("Départ"),
              // DropdownButton(
              //   items: StreamBuilder(
              //     stream: _stationService.getAllStations(),
              //     builder: (context, snapshot) {
              //       switch (snapshot.connectionState) {
              //         case ConnectionState.waiting:
              //         case ConnectionState.active:
              //           if (snapshot.hasData) {
              //             final allStations = snapshot.data as Iterable<CloudStation>;
              //             return allStations.toList();
              //           }

              //         default:
              //           return const CircularProgressIndicator();
              //       }
              //     },
              //   ),
              //   onChanged: (_) {},
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
