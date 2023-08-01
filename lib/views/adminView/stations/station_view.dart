import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/views/adminView/stations/station_list.dart';

import 'create_or_update_station.dart';

class StationView extends StatefulWidget {
  const StationView({super.key});

  @override
  State<StationView> createState() => _StationViewState();
}

class _StationViewState extends State<StationView> {
  late final FirebaseCloudStationStorage _stationService;

  @override
  void initState() {
    _stationService = FirebaseCloudStationStorage();
    super.initState();
  }

  void _startAddStation(BuildContext context, CloudStation? station) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (_) {
        if (station != null) {
          return CreateOrUpdateStation(station: station);
        }else{
          return const CreateOrUpdateStation(station: null);
        }
        
      },
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _stationService.getAllStations(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allStations = snapshot.data as Iterable<CloudStation>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Stations recentes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    Expanded(
                      child: StationsList(
                        stations: allStations,
                        onDeleteNote: (CloudStation station) async {
                          await _stationService.deleteStation(
                              documentId: station.documentId);
                        },
                        onTap: (station) {
                          _startAddStation(context, station);
                          // Navigator.of(context).pushNamed(
                          //     createOrUpdateStationRoute,
                          //     arguments: station);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            case ConnectionState.done:
              return const Text('done');
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddStation(context, null),
      ),
    );
  }
}
