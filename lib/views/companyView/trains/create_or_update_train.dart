import 'package:flutter/material.dart';
import 'package:mypfe/widgets/train/add_train.dart';

class CreateOrUpdateTrain extends StatefulWidget {
  const CreateOrUpdateTrain({super.key});

  @override
  State<CreateOrUpdateTrain> createState() => _CreateOrUpdateTrainState();
}

class _CreateOrUpdateTrainState extends State<CreateOrUpdateTrain> {
  late final TextEditingController _numero;
  late final TextEditingController _nbrClasse;

  @override
  void initState() {
    _numero = TextEditingController();
    _nbrClasse = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AddTrain(numero: _numero, nbrClasse: _nbrClasse, suivant: (){});
  }
}