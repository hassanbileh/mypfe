import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudClasseStorage {
  FirebaseCloudClasseStorage._sharedInstance();
  static final _shared = FirebaseCloudClasseStorage._sharedInstance();
  factory FirebaseCloudClasseStorage() => _shared;

  CollectionReference trainCollection =
      FirebaseFirestore.instance.collection('trains');

  Future<CloudClasse> createNewClasse({
    required String trainId,
    required String nomClasse,
    required int capacite,
    required int places,
    required String description,
    required double prixClasse,
  }) async {
    try {
      final classesCollection =
          FirebaseFirestore.instance.collection('classes');
      final document = await classesCollection.add({
        "nom": nomClasse,
        "capacite": capacite,
        "placesDisponibles": places,
        "description": description,
        "prix_classe": prixClasse,
        "train_id": trainId,
      });
      final fetchedClasse = await document.get();
      return CloudClasse(
        documentId: fetchedClasse.id,
        nom: nomClasse,
        capacite: capacite,
        description: description,
        prixClasse: prixClasse,
        trainId: trainId,
        places: places,
      );
    } catch (e) {
      throw CouldNotCreateClasseException();
    }
  }

  Future<void> updateClasse({
    required String documentId,
    required String nom,
    required String description,
    required int capacite,
    required int places,
    required double prixClasse,
  }) async {
    try {
      final classesCollection =
          FirebaseFirestore.instance.collection('classes');
      await classesCollection.doc(documentId).update({
        "nom": nom,
        "description": description,
        "capacite": capacite,
        "placesDisponibles": places,
        "prix_classe": prixClasse,
      });
    } catch (e) {
      throw CouldNotUpdateClasseException();
    }
  }

  Future<void> deleteClasse({required String documentId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('classes')
          .doc(documentId)
          .delete();
    } catch (e) {
      throw CouldNotDeleteClasseException();
    }
  }

  Stream<Iterable<CloudClasse>> getClassesByTrainId(
      {required String? trainId}) {
    final allClasses = FirebaseFirestore.instance
        .collection('classes')
        .snapshots()
        .map((event) => event.docs
            .map((doc) => CloudClasse.fromSnapshot(doc))
            .where((classe) => classe.trainId == trainId));
    return allClasses;
  }
}
