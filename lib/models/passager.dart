import 'package:cloud_firestore/cloud_firestore.dart';


class CloudPassager {
  final String documentId;
  final String nom;
  final String? nationalite;
  final int age;
  final String genre;
  final String numPasseport;
  final String trainId;
  final String reservationId;

  const CloudPassager({
    required this.documentId,
    required this.nom,
    required this.nationalite,
    required this.age,
    required this.genre,
    required this.numPasseport,
    required this.trainId,
    required this.reservationId,
  });

  CloudPassager.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        nom = snapshot.data()["nom"] as String,
        nationalite = snapshot.data()["nationalite"] as String,
        age = snapshot.data()["age"] as int,
        genre = snapshot.data()["genre"] as String,
        numPasseport = snapshot.data()["numPasseport"] as String,
        trainId = snapshot.data()["trainId"] as String,
        reservationId = snapshot.data()["reservationId"] as String;
}
