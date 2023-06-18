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
    required int? nbrTypeSiege,
    required String nomClasse,
    required int capacite,
    required String description,
    required double prixClasse,
  }) async {
    try {
      final classesCollection =
          trainCollection.doc(trainId).collection('classes');
      final document = await classesCollection.add({
        "nom": nomClasse,
        "capacité": capacite,
        "description": description,
        "nbr_type_siege": nbrTypeSiege as int,
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
        nbrTypeSiege: nbrTypeSiege,
        trainId: trainId,
        typesSiege: [],
      );
    } catch (e) {
      throw CouldNotCreateClasseException();
    }
  }
}
