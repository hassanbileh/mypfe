import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/widgets/classe/add_class_form.dart';

class AddClasse extends StatefulWidget {
  const AddClasse({super.key});

  @override
  State<AddClasse> createState() => _AddClasseState();
}

class _AddClasseState extends State<AddClasse> {
  CloudClasse? _classe;
  late final FirebaseCloudClasseStorage _classeService;
  late final TextEditingController _nom;
  late final TextEditingController _description;
  late final TextEditingController _capacite;
  late final TextEditingController _nbrTypeSiege;
  late final TextEditingController _prixClasse;

  @override
  void initState() {
    _nom = TextEditingController();
    _description = TextEditingController();
    _capacite = TextEditingController();
    _nbrTypeSiege = TextEditingController();
    _prixClasse = TextEditingController();
    _classeService = FirebaseCloudClasseStorage();
    super.initState();
  }

  createClasse(BuildContext context) async {
    try {
      final widgetTrain = context.getArguments<CloudTrain>();
      if (widgetTrain != null &&
          _nom.text.isNotEmpty &&
          int.tryParse(_capacite.text) != null &&
          double.tryParse(_prixClasse.text) != null
          ) {
        final trainId = widgetTrain.documentId;
        await _classeService.createNewClasse(
          trainId: trainId,
          nbrTypeSiege: int.tryParse(_nbrTypeSiege.text.trim())!,
          nomClasse: _nom.text.trim(),
          capacite: int.tryParse(_capacite.text.trim())!,
          description: _description.text.trim(),
          prixClasse: double.tryParse(_prixClasse.text)!,
        );
        Navigator.of(context).pop();
      } 
    } catch (e) {
      throw CouldNotCreateClasseException();
    }
  }

  @override
  void dispose() {
    _nom.dispose();
    _description.dispose();
    _capacite.dispose();
    _nbrTypeSiege.dispose();
    _prixClasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassForm(
              nom: _nom,
              description: _description,
              capacite: _capacite,
              nbrTypeSiege: _nbrTypeSiege,
              prixClasse: _prixClasse,
              suivant: () => createClasse(context),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 80,
                width: 300,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: const Card(
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Ajouter un type de siège',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
