import 'package:cloud_firestore/cloud_firestore.dart';

enum CategoryClass{
  vip,
  business,
  economie,

}


class CloudClasse {
  final String documentId;
  final String nom;
  final int capacite;
  final int places;
  final String? description;
  final double prixClasse;
  final String trainId;
  final String trainNum;

  const CloudClasse( {
    required this.documentId,
    required this.nom,
    required this.capacite,
    required this.places,
    required this.description,
    required this.prixClasse,
    required this.trainId,
    required this.trainNum,
  });

  CloudClasse.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) : 
  documentId = snapshot.id,
  nom = snapshot.data()['nom'] as String,
  capacite = snapshot.data()['capacite'] as int,
  places = snapshot.data()['placesDisponibles'] as int,
  description = snapshot.data()['description'] as String,
  prixClasse = snapshot.data()['prix_classe'] as double,
  trainId = snapshot.data()['train_id'] as String,
  trainNum = snapshot.data()['trainNum'] as String;

}