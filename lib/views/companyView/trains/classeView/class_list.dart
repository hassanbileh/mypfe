import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/utilities/dialogs/delete_dialog.dart';

typedef TrainCallBack = void Function(CloudClasse train);

class ClasseList extends StatelessWidget {
  final Iterable<CloudClasse?> classes;
  final TrainCallBack onModify;
  final TrainCallBack onDelete;

  const ClasseList({
    super.key,
    required this.classes,
    required this.onModify,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        final classe = classes.elementAt(index)!;
        return Card(
          color: Colors.white.withOpacity(1),
          elevation: 3,
          child: Dismissible(
            key: ValueKey(classes.elementAt(index)),
            dragStartBehavior: DragStartBehavior.down,
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
                onDelete(classe);
              }
            },
            child: ExpansionTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        classe.nom,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      ListTile(
                        title: Text(
                          classe.description!,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Places disponibles',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Text(
                                classe.places.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              const Text(
                                'Prix',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Text(
                                classe.prixClasse.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              leading: const Icon(Icons.hotel_class),
              trailing: IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDeleteDialog(context);
                    if (shouldDelete) {
                      onDelete(classe);
                    }
                  },
                  icon: const Icon(Icons.delete)),
              children: [
                ListTile(
                  title: const Text('Voir'),
                  leading: const Icon(Icons.remove_red_eye_outlined),
                  onTap: () {
                    onModify(classe);
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
