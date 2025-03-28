import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/widgets/classe/add_class_form.dart';

class AddClasse extends StatefulWidget {
  const AddClasse({super.key});

  @override
  State<AddClasse> createState() => _AddClasseState();
}

class _AddClasseState extends State<AddClasse> {
  late final FirebaseCloudClasseStorage _classeService;
  late final TextEditingController _nom;
  late final TextEditingController _description;
  late final TextEditingController _capacite;
  late final TextEditingController _places;
  late final TextEditingController _prixClasse;

  @override
  void initState() {
    _nom = TextEditingController();
    _description = TextEditingController();
    _capacite = TextEditingController();
    _places = TextEditingController();
    _prixClasse = TextEditingController();
    _classeService = FirebaseCloudClasseStorage();
    super.initState();
  }

  void createClasse(BuildContext context) async {
    try {
      final widgetTrain = context.getArguments<CloudTrain>();
      if (widgetTrain != null &&
          _nom.text.isNotEmpty &&
          int.tryParse(_capacite.text) != null &&
          int.tryParse(_places.text) != null &&
          double.tryParse(_prixClasse.text) != null) {
        final trainId = widgetTrain.documentId;
        final trainNum = widgetTrain.numero;
        await _classeService.createNewClasse(
          trainId: trainId,
          nomClasse: _nom.text.trim(),
          capacite: int.tryParse(_capacite.text.trim())!,
          description: _description.text.trim(),
          prixClasse: double.tryParse(_prixClasse.text)!,
          places: int.tryParse(_places.text.trim())!,
          trainNum: trainNum,
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
    _places.dispose();
    _prixClasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        title: const Text('Classes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassForm(
              nom: _nom,
              description: _description,
              capacite: _capacite,
              prixClasse: _prixClasse,
              suivant: () => createClasse(context),
              placesDisponibles: _places,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
