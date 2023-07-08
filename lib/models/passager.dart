import 'package:cloud_firestore/cloud_firestore.dart';


class CloudPassager {
  final String documentId;
  final String nom;
  final String? nationalite;
  final int age;
  final String genre;
  final String passeport;
  final String ticket;
  final String reservation;
  final String creePar;
  final String classe;

  const CloudPassager({
    required this.documentId,
    required this.nom,
    required this.nationalite,
    required this.age,
    required this.genre,
    required this.passeport,
    required this.ticket, 
    required this.reservation,
    required this.classe,
    required this.creePar,
  });

  CloudPassager.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        nom = snapshot.data()["nom"] as String,
        nationalite = snapshot.data()["nationalite"] as String,
        age = snapshot.data()["age"] as int,
        genre = snapshot.data()["genre"] as String,
        passeport = snapshot.data()["passeport"] as String,
        ticket = snapshot.data()["ticket"] as String,
        reservation = snapshot.data()["reservation"] as String,
        classe = snapshot.data()["classe"] as String,
        creePar = snapshot.data()["creePar"] as String;
}
