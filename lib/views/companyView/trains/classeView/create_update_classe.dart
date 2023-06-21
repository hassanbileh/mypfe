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

  Future<CloudClasse?> createOrUpdateClasse(BuildContext context) async {
    final widgetClasse = context.getArguments<CloudClasse>();
    if (widgetClasse != null) {
      _nom.text = widgetClasse.nom;
      _description.text = widgetClasse.description!;
      _capacite.text = widgetClasse.capacite.toString();
      _nbrTypeSiege.text = widgetClasse.nbrTypeSiege.toString();
      _prixClasse.text = widgetClasse.prixClasse.toString();
      return widgetClasse;
    }
  }

  void _textControllerListener() async {
    final classe = _classe;
    if (classe != null) {
      final nom = _nom.text;
      final description = _description.text;
      final capacite = int.tryParse(_capacite.text);
      final nbrTypeSiege = int.tryParse(_nbrTypeSiege.text);
      final prixClasse = double.tryParse(_prixClasse.text);
      await _classeService.updateClasse(
        documentId: classe.documentId,
        nom: nom,
        description: description,
        capacite: capacite!,
        prixClasse: prixClasse!,
        nbrTypeSiege: nbrTypeSiege!,
      );
    }
  }

  void _setUpTextControllerListener() {
    _nom.removeListener(_textControllerListener);
    _description.removeListener(_textControllerListener);
    _capacite.removeListener(_textControllerListener);
    _prixClasse.removeListener(_textControllerListener);
    _nbrTypeSiege.removeListener(_textControllerListener);

    _nom.addListener(_textControllerListener);
    _description.addListener(_textControllerListener);
    _capacite.addListener(_textControllerListener);
    _prixClasse.addListener(_textControllerListener);
    _nbrTypeSiege.addListener(_textControllerListener);
  }

  void deleteClasseIfTextAreEmpty() async {
    final classe = _classe;
    final nom = _nom.text;
    final description = _description.text;
    final capacite = int.tryParse(_capacite.text);
    final nbrTypeSiege = int.tryParse(_nbrTypeSiege.text);
    final prixClasse = double.tryParse(_prixClasse.text);
    if (nom.isEmpty ||
        capacite == null ||
        prixClasse == null && classe != null) {
      await _classeService.deleteClasse(documentId: classe!.documentId);
    }
  }

  void saveClasseIfTextNotEmpty() async {
    final classe = _classe;
    final nom = _nom.text;
    final description = _description.text;
    final capacite = int.tryParse(_capacite.text);
    final nbrTypeSiege = int.tryParse(_nbrTypeSiege.text);
    final prixClasse = double.tryParse(_prixClasse.text);
    if (classe != null &&
        nom.isNotEmpty &&
        capacite != null &&
        prixClasse != null) {
      await _classeService.updateClasse(
        documentId: classe.documentId,
        nom: nom,
        description: description,
        capacite: capacite,
        prixClasse: prixClasse,
        nbrTypeSiege: nbrTypeSiege!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
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
                    nbrTypeSiege: _nbrTypeSiege,
                    prixClasse: _prixClasse,
                    suivant: null);
              default : 
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
