import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/widgets/no_item.dart';

class StationView extends StatefulWidget {
  const StationView({super.key});

  @override
  State<StationView> createState() => _StationViewState();
}

class _StationViewState extends State<StationView> {
  final Iterable<CloudStation> _stationsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: (_stationsList.isEmpty)
            ? const NoItem(title: 'Aucune station trouvée.')
            : Column(
                children: [
                  const Text('Stations recents'),
                ],
              ),
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