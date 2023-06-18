import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/views/companyView/trains/add_train_form.dart';

class CreateOrUpdateTrain extends StatefulWidget {
  const CreateOrUpdateTrain({super.key});

  @override
  State<CreateOrUpdateTrain> createState() => _CreateOrUpdateTrainState();
}

class _CreateOrUpdateTrainState extends State<CreateOrUpdateTrain> {
  CloudTrain? _train;
  late final FirebaseCloudTrainStorage _trainService;
  late final TextEditingController _numero;
  late final TextEditingController _nbrClasse;

  @override
  void initState() {
    _trainService = FirebaseCloudTrainStorage();
    _numero = TextEditingController();
    _nbrClasse = TextEditingController();
    super.initState();
  }

  _submitTrainData() async{
    try {
      final numero = _numero.text.trim();
      final nbrClasse = int.tryParse(_nbrClasse.text.trim());
      if (numero.isEmpty || _nbrClasse.text.isEmpty) {
        await showErrorDialog(context, 'Veuillez remplir tous les champs');
      }
      final user = AuthService.firebase().currentUser;
      final companyEmail = user!.email;
      await _trainService.createNewTrain(companyEmail: companyEmail, nbrClasses: nbrClasse!, numero: numero);
      Navigator.of(context)
            .pushNamed(addClasseRoute, arguments: nbrClasse);
    } catch (e) {
      throw CouldNotCreateTrainException();
    }
  }

  @override
  void dispose() {
    _numero.dispose();
    _nbrClasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddTrain(
      numero: _numero,
      nbrClasse: _nbrClasse,
      suivant: _submitTrainData,
    );
  }
}
