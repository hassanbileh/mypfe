import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';
import 'package:mypfe/widgets/station/station_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: StreamBuilder(
        stream: _stationService.getAllStations(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allStations = snapshot.data as Iterable<CloudStation>;
                return StationsList(
                  stations: allStations,
                  onDeleteNote: (CloudStation station) async {
                    await _stationService.deleteStation(
                        documentId: station.documentId);
                  },
                  onTap: (station) {
                    Navigator.of(context).pushNamed(createOrUpdateStationRoute,
                        arguments: station);
                  },
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
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateStationRoute);
        },
      ),
    );
  }
}
