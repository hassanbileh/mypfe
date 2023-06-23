import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:mypfe/views/companyView/trains/classeView/class_list.dart';
import 'package:mypfe/widgets/train/add_train.dart';

class CreateOrUpdateTrain extends StatefulWidget {
  const CreateOrUpdateTrain({super.key});

  @override
  State<CreateOrUpdateTrain> createState() => _CreateOrUpdateTrainState();
}

class _CreateOrUpdateTrainState extends State<CreateOrUpdateTrain> {
  CloudTrain? _train;
  late final TextEditingController _numero;
  late final TextEditingController _nbrClasse;
  late final FirebaseCloudTrainStorage _trainService;
  late final FirebaseCloudClasseStorage _classeService;
  String get userEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _numero = TextEditingController();
    _nbrClasse = TextEditingController();
    _trainService = FirebaseCloudTrainStorage();
    _classeService = FirebaseCloudClasseStorage();
    super.initState();
  }

  // fonction qui ecoute et enregistre la note instantannement que l'utilisateur tape sur le clavier
  void _textControllerListener() async {
    final train = _train;
    if (train != null) {
      final numero = _numero.text;
      final nbrClasse = int.tryParse(_nbrClasse.text);
      await _trainService.updateTrain(
        documentId: train.documentId,
        numero: numero,
        nbrClasse: nbrClasse!,
      );
    } else {
      return;
    }
  }

  void _setUpTextControllerListener() {
    _numero.removeListener(_textControllerListener);
    _nbrClasse.removeListener(_textControllerListener);
    _numero.addListener(_textControllerListener);
    _nbrClasse.addListener(_textControllerListener);
  }

  void _deleteTrainIfTextIsEmpty() async {
    final train = _train;
    final nbrClasse = int.tryParse(_nbrClasse.text);
    if (_numero.text.isEmpty && nbrClasse == null && train != null) {
      await _trainService.deleteTrain(documentId: train.documentId);
    }
  }

// Fonction qui enregistre la note si elle n'est pas vide lorsque le btton retour est touché
  void _saveTrainIfTextNotEmpty() async {
    final train = _train;
    final numero = _numero.text;
    final nbrClasse = int.tryParse(_nbrClasse.text)!;
    if (train != null && numero.isNotEmpty && _nbrClasse.text.isNotEmpty) {
      await _trainService.updateTrain(
        documentId: train.documentId,
        numero: numero,
        nbrClasse: nbrClasse,
      );
    }
  }

  // ? Créer ou Modifier Note
  Future<CloudTrain> createOrUpdateTrain(BuildContext context) async {
    //Getting arguments passed in navigator route
    final widgetTrain = context.getArguments<CloudTrain>();

    if (widgetTrain != null) {
      _train = widgetTrain;
      _numero.text = widgetTrain.numero;
      _nbrClasse.text = widgetTrain.nbrClasses.toString();

      return widgetTrain;
    }

    final existingTrain = _train;
    if (existingTrain != null) {
      return existingTrain;
    } else {
      final newTrain = await _trainService.createNewTrain(
        companyEmail: userEmail,
      );
      _train = newTrain;
      return newTrain;
    }
  }

  @override
  void dispose() {
    _deleteTrainIfTextIsEmpty();
    _saveTrainIfTextNotEmpty();
    _numero.dispose();
    _nbrClasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final train = context.getArguments<CloudTrain>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
                future: createOrUpdateTrain(context),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      _setUpTextControllerListener();
                      return AddTrain(
                        numero: _numero,
                        nbrClasse: _nbrClasse,
                      );
                    default:
                      return const CircularProgressIndicator();
                  }
                }),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                  'Recent Classes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
            ),
            SizedBox(
              height: 300,
              child: StreamBuilder(
                stream: _classeService.getClassesByTrainId(trainId: train?.documentId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allClasses = snapshot.data as Iterable<CloudClasse>;
                        return ClasseList(
                          classes: allClasses,
                          onModify: (CloudClasse classe) {
                            Navigator.of(context).pushNamed(
                                createOrUpdateClasseRoute,
                                arguments: classe);
                          },
                          onDelete: (CloudClasse classe) async {
                            await _classeService.deleteClasse(
                                documentId: classe.documentId);
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
            ),
          ],
        ),
      ),
    );
  }
}
