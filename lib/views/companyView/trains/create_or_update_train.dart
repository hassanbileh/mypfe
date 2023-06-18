import 'package:flutter/material.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
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

  @override
  void initState() {
    _trainService = FirebaseCloudTrainStorage();
    _numero = TextEditingController();
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {
    return AddTrain(numero: _numero);
  }
}