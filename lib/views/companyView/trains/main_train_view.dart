import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:mypfe/views/companyView/trains/train_list.dart';

class TrainView extends StatefulWidget {
  const TrainView({super.key});

  @override
  State<TrainView> createState() => _TrainViewState();
}

class _TrainViewState extends State<TrainView> {
  late final FirebaseCloudTrainStorage _trainService;
  String get compagnieEmail => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    _trainService = FirebaseCloudTrainStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: StreamBuilder(
        stream: _trainService.getTrainsByCompany(compagnieEmail: compagnieEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allTrains = snapshot.data as Iterable<CloudTrain>;
                return TrainList(
                  trains: allTrains,
                  onModify: (CloudTrain train) {
                    Navigator.of(context)
                        .pushNamed(createOrUpdateTrainRoute, arguments: train);
                  },
                  onDelete: (CloudTrain train) async{
                    await _trainService.deleteTrain(documentId: train.documentId);
                  },
                  onAddClass: (CloudTrain train) {
                    Navigator.of(context)
                        .pushNamed(addClasseRoute, arguments: train);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(createOrUpdateTrainRoute);
        },
      ),
    );
  }
}
