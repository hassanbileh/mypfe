import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/widgets/classe/add_class_form.dart';

class CreateOrUpdateClasse extends StatefulWidget {
  const CreateOrUpdateClasse({super.key});

  @override
  State<CreateOrUpdateClasse> createState() => _CreateOrUpdateClasseState();
}

class _CreateOrUpdateClasseState extends State<CreateOrUpdateClasse> {
  CloudClasse? _classe;
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

  Future<CloudClasse?> createOrUpdateClasse(BuildContext context) async {
    final widgetClasse = context.getArguments<CloudClasse>();
    if (widgetClasse != null) {
      _nom.text = widgetClasse.nom;
      _description.text = widgetClasse.description!;
      _capacite.text = widgetClasse.capacite.toString();
      _places.text = widgetClasse.places.toString();
      _prixClasse.text = widgetClasse.prixClasse.toString();
      return widgetClasse;
    } else {
      throw CouldNotCreateClasseException();
    }
  }

  void _textControllerListener() async {
    final classe = _classe;
    final nom = _nom.text;
    final description = _description.text;
    final capacite = int.tryParse(_capacite.text);
    final places = int.tryParse(_places.text);
    final prixClasse = double.tryParse(_prixClasse.text);
    if (classe != null) {
      await _classeService.updateClasse(
        documentId: classe.documentId,
        nom: nom,
        description: description,
        capacite: capacite!,
        prixClasse: prixClasse!,
        places: places!,
      );
    } else {
      return;
    }
  }

  void _setUpTextControllerListener() {
    _nom.removeListener(_textControllerListener);
    _description.removeListener(_textControllerListener);
    _capacite.removeListener(_textControllerListener);
    _places.removeListener(_textControllerListener);
    _prixClasse.removeListener(_textControllerListener);
    _nom.addListener(_textControllerListener);
    _description.addListener(_textControllerListener);
    _capacite.addListener(_textControllerListener);
    _places.addListener(_textControllerListener);
    _prixClasse.addListener(_textControllerListener);
  }

  void _deleteClasseIfTextAreEmpty() async {
    final classe = _classe;
    final nom = _nom.text;
    final capacite = int.tryParse(_capacite.text);
    final prixClasse = double.tryParse(_prixClasse.text);
    if (nom.isEmpty ||
        capacite == null ||
        prixClasse == null && classe != null) {
      await _classeService.deleteClasse(documentId: classe!.documentId);
    }
  }

  void _saveClasseIfTextNotEmpty() async {
    final classe = _classe;
    final nom = _nom.text;
    final description = _description.text;
    final capacite = int.tryParse(_capacite.text);
    final places = int.tryParse(_places.text);
    final prixClasse = double.tryParse(_prixClasse.text);
    if (classe != null &&
        nom.isNotEmpty &&
        capacite != null &&
        places != null &&
        prixClasse != null) {
      await _classeService.updateClasse(
        documentId: classe.documentId,
        nom: nom,
        description: description,
        capacite: capacite,
        prixClasse: prixClasse,
        places: places,
      );
    }
  }

  @override
  void dispose() {
    _deleteClasseIfTextAreEmpty();
    _saveClasseIfTextNotEmpty();
    _nom.dispose();
    _description.dispose();
    _capacite.dispose();
    _prixClasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: createOrUpdateClasse(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _setUpTextControllerListener();
                return ClassForm(
                  nom: _nom,
                  description: _description,
                  capacite: _capacite,
                  prixClasse: _prixClasse,
                  suivant: null,
                  placesDisponibles: _places,
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
