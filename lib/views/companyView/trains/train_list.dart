import 'package:flutter/material.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/utilities/dialogs/delete_dialog.dart';

typedef TrainCallBack = void Function(CloudTrain train);

class TrainList extends StatelessWidget {
  final Iterable<CloudTrain?> trains;
  final TrainCallBack onModify;
  final TrainCallBack onDelete;
  final TrainCallBack onAddClass;

  const TrainList({
    super.key,
    required this.trains,
    required this.onModify,
    required this.onDelete,
    required this.onAddClass,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trains.length,
      itemBuilder: (context, index) {
        final train = trains.elementAt(index)!;
        return Card(
          color: Colors.white.withOpacity(1),
          elevation: 3,
          child: Dismissible(
            key: ValueKey(trains.elementAt(index)),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Supprimer',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            onDismissed: (direction) async {
              final shouldDelete = await showDeleteDialog(context);
              if (shouldDelete) {
                onDelete(train);
              }
            },
            child: ExpansionTile(
              title: Text(train.numero),
              leading: const Icon(Icons.train_outlined),
              trailing: IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDeleteDialog(context);
                    if (shouldDelete) {
                      onDelete(train);
                    }
                  },
                  icon: const Icon(Icons.delete)),
              children: [
                ListTile(
                  title: const Text('Ajouter une classe'),
                  leading: const Icon(Icons.add),
                  onTap: () {
                    onAddClass(train);
                  },
                ),
                ListTile(
                  title: const Text('Voir'),
                  leading: const Icon(Icons.remove_red_eye_outlined),
                  onTap: () {
                    onModify(train);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
