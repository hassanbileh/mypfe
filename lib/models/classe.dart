import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/type_siege.dart';

class CloudClasse {
  final String documentId;
  final String nom;
  final int capacite;
  final String? description;
  final double prixClasse;
  final int? nbrTypeSiege;
  final String trainId;
  final Iterable<CloudTypeSiege>? typesSiege;

  const CloudClasse({
    required this.documentId,
    required this.nom,
    required this.capacite,
    required this.description,
    required this.prixClasse,
    required this.nbrTypeSiege,
    required this.trainId,
    required this.typesSiege,
  });

  CloudClasse.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) : 
  documentId = snapshot.id,
  nom = snapshot.data()['nom'] as String,
  capacite = snapshot.data()['capacite'] as int,
  description = snapshot.data()['description'] as String,
  prixClasse = snapshot.data()['prix_classe'] as double,
  nbrTypeSiege = snapshot.data()['nbr_type_siege'] as int,
  trainId = snapshot.data()['train_id'] as String,
  typesSiege = (snapshot.data()['typeSiege'] as Iterable<CloudTypeSiege>).map((dynamic ts) => CloudTypeSiege.fromSnapshot(ts as QueryDocumentSnapshot<Map<String, dynamic>>)).toList();

}