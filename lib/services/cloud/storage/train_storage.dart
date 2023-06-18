import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/classe.dart';
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
    required List<CloudClasse> classes,
  }) async {
    try {
      final document = await trains.add({
        "compagnieEmail": companyEmail,
        "nbr_classes": nbrClasses,
        "numero": numero,
        "classes": classes,
      });
      final fetchedTrain = await document.get();
      return CloudTrain(
        documentId: fetchedTrain.id,
        numero: numero,
        companyEmail: companyEmail,
        nbrClasses: nbrClasses,
        classes: classes,
      );
    } catch (e) {
      throw CouldNotCreateTrainException();
    }
  }

  Future<void> updateTrain({required String documentId}) async {
    
  }
}
