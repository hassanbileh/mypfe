import 'package:cloud_firestore/cloud_firestore.dart';

class CloudTypeSiege {
  final String documentId;
  final String nom;
  final int quantite;
  final int quantiteLibre;
  final double prixType;
  final String classeId;

  const CloudTypeSiege({
    required this.documentId,
    required this.nom,
    required this.quantite,
    required this.quantiteLibre,
    required this.prixType,
    required this.classeId,
  });

  CloudTypeSiege.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        nom = snapshot.data()['nom'] as String,
        quantite = snapshot.data()['quantite'] as int,
        quantiteLibre = snapshot.data()['quantite_libre'] as int,
        prixType = snapshot.data()['prix_type'] as double,
        classeId = snapshot.data()['classe_id'] as String;
}
