import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudTrainStorage {
  FirebaseCloudTrainStorage._sharedInstance();
  factory FirebaseCloudTrainStorage() => _shared;
  static final _shared = FirebaseCloudTrainStorage._sharedInstance();

  CollectionReference _trains = FirebaseFirestore.instance.collection('trains');

  Future<CloudTrain> createNewTrain({
    required String companyEmail,
  }) async {
    try {
      final document = await _trains.add({
        "compagnieEmail": companyEmail,
        "nbr_clases": 0,
        "numero": '',
      });
      final fetchedTrain = await document.get();
      return CloudTrain(
        documentId: fetchedTrain.id,
        numero: '',
        companyEmail: companyEmail,
        nbrClasses: 0,
      );
    } catch (e) {
      throw CouldNotCreateTrainException();
    }
  }

  Future<void> updateTrain({
    required String documentId,
    required String numero,
    required int nbrClasse,
  }) async {
    try {
      await _trains.doc(documentId).update({
        "numero": numero,
        "nbr_clases": nbrClasse,
      });
    } catch (e) {
      throw CouldNotUpdateTrainException();
    }
  }

  Future<void> deleteTrain({required String documentId}) async {
    try {
      await _trains.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteTrainException();
    }
  }

  Stream<Iterable<CloudTrain>> getTrainsByCompany(
      {required String compagnieEmail}) {
    final allTrains = FirebaseFirestore.instance
        .collection('trains')
        .snapshots()
        .map((event) => event.docs
            .map((doc) => CloudTrain.fromSnapshot(doc))
            .where((train) => train.companyEmail == compagnieEmail));
    return allTrains;
  }

  // //Getting trains by companyEmail
  // Future<Iterable<CloudTrain>> getTrains({required String companyEmail}) async {
  //   try {
  //     final gotNotes = await FirebaseFirestore.instance
  //         .collection('trains')
  //         .where(
  //           'compagnieEmail',
  //           isEqualTo: companyEmail,
  //         )
  //         .get()
  //         .then(
  //           // onError: (_) => CloudNotGetAllNotesException(),
  //           (value) => value.docs.map((doc) => CloudTrain.fromSnapshot(doc)),
  //         );
  //     return gotNotes;
  //   } catch (e) {
  //     throw CouldNotGetTrainsException();
  //   }
  // }

  Future<String> getTrain({required String trainNum}) async {
    try {
      final trainDoc = await FirebaseFirestore.instance
          .collection('trains')
          .where('trainNum', isEqualTo: trainNum)
          .get()
          .then((value) => CloudTrain.fromSnapshot(
              value as QueryDocumentSnapshot<Map<String, dynamic>>));
      final train = trainDoc.documentId;
      return train;
    } catch (e) {
      throw CouldNotReadTrainException();
    }
  }
}
