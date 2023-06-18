import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/train.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudTrainStorage {
  FirebaseCloudTrainStorage._sharedInstance();
  factory FirebaseCloudTrainStorage() => _shared;
  static final _shared = FirebaseCloudTrainStorage._sharedInstance();

  CollectionReference trains = FirebaseFirestore.instance.collection('trains');

  Future<CloudTrain> createNewTrain({
    required String companyEmail,
    required int nbrClasses,
    required String numero,
  }) async {
    try {
      final document = await trains.add({
        "compagnieEmail": companyEmail,
        "nbr_classes": nbrClasses,
        "numero": numero,
      });
      final fetchedTrain = await document.get();
      return CloudTrain(
        documentId: fetchedTrain.id,
        numero: numero,
        companyEmail: companyEmail,
        nbrClasses: nbrClasses,
        classes: [],
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
      await trains.doc(documentId).update({
        "numero": numero,
        "nbr_classes": nbrClasse,
      });
    } catch (e) {
      throw CouldNotUpdateTrainException();
    }
  }

  Future<void> deleteTrain({required String documentId}) async {
    try {
      await trains.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteTrainException();
    }
  }

  Stream<Iterable<CloudTrain>> getTrainsByCompany(
          {required String compagnieEmail}) =>
      trains.snapshots().map((event) => event.docs
          .map((doc) => CloudTrain.fromSnapshot(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>))
          .where((train) => train.companyEmail == compagnieEmail));
}
