import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/train_storage.dart';
import 'package:mypfe/views/companyView/trains/create_or_update_train.dart';
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

  void _startAddNewTicket(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: ctx,
      builder: (_) {
        return const CreateOrUpdateTrain(isNew: true,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Train recents',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Expanded(
            child: StreamBuilder(
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
                      return CircularProgressIndicator(backgroundColor: Colors.deepPurple[500],);
                    }
                  case ConnectionState.done:
                    return const Text('done');
                  default:
                    return CircularProgressIndicator(backgroundColor: Colors.deepPurple[500],);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _startAddNewTicket(context);
          // Navigator.of(context).pushNamed(createOrUpdateTrainRoute);
        },
      ),
    );
  }
}
