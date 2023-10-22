import 'package:flutter/material.dart';
import 'package:mypfe/services/cloud/storage/station_storage.dart';

import '../../../models/station.dart';

class CompanyStationView extends StatefulWidget {
  const CompanyStationView({super.key});

  @override
  State<CompanyStationView> createState() => _CompanyStationViewState();
}

class _CompanyStationViewState extends State<CompanyStationView> {
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Stations recents',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allStations.length,
                        itemBuilder: (context, index) {
                          final station = allStations.elementAt(index);
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                station.nom,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
                    )
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
    );
  }
}
