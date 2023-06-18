import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/type_siege.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudTypeSiegeStorage {
  FirebaseCloudTypeSiegeStorage._sharedInstance();
  factory FirebaseCloudTypeSiegeStorage() => _shared;
  static final _shared = FirebaseCloudTypeSiegeStorage._sharedInstance();

  CollectionReference trainCollection =
      FirebaseFirestore.instance.collection('trains');

  Future<CloudTypeSiege?> createNewTypeSiege({
    required String trainId,
    required String classeId,
    required String nom,
    required int nbrTypeSiege,
    required int quantite,
    required int quantiteDispo,
    required double prixType,
  }) async {
    try {
      final typeSiegeCollection = trainCollection.doc(trainId).collection('classes').doc(classeId).collection('typeSiege');
      final document = await typeSiegeCollection.add({
        "nom": nom,
        "quantite": quantite,
        "quantite_libre": quantiteDispo,
        "prix_type": prixType,
        "classe_id": classeId,
      });
      final fetchedTypeSiege = await document.get();
      return CloudTypeSiege(
        documentId: fetchedTypeSiege.id,
        nom: nom,
        quantite: quantite,
        quantiteLibre: quantiteDispo,
        prixType: prixType,
        classeId: classeId,
      );
    } catch (e) {
      throw CouldNotCreateTypeSiegeException();
    }
  }
}
