

import 'package:flutter/material.dart';
import 'package:mypfe/models/station.dart';

import '../../../utilities/dialogs/delete_dialog.dart';

typedef StationCallBack = void Function(CloudStation note);

class StationsList extends StatelessWidget {
  const StationsList({
    super.key,
    required this.stations,
    required this.onDeleteNote,
    required this.onTap,
  });

  final Iterable<CloudStation?> stations;
  final StationCallBack? onDeleteNote;
  final StationCallBack? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations.elementAt(index);
        return Card(
          child: Dismissible(
            key: ValueKey(stations.elementAt(index)),
            onDismissed: (direction) async {
              final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote!(station);
                  }
            },
            background: Container(color: Theme.of(context).colorScheme.error,),
            child: ListTile(
              tileColor: Colors.white70,
              onTap:() {
                onTap!(station);
              },
              title: Text(
                station!.nom,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Color.fromARGB(255, 148, 115, 238),),
                onPressed: () async {
                  final shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete) {
                    onDeleteNote!(station);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
