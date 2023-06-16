import 'package:cloud_firestore/cloud_firestore.dart';

class CloudStation {
  const CloudStation({
    required this.documentId,
    required this.numero,
    required this.nom,
    required this.ville,
    required this.adminEmail,
  });

  final String documentId;
  final String numero;
  final String nom;
  final String ville;
  final String adminEmail;

  CloudStation.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        numero = snapshot.data()['numero'],
        nom = snapshot.data()['nom'],
        ville = snapshot.data()['ville'],
        adminEmail = snapshot.data()['adminEmail'];

  @override
  bool operator ==(covariant CloudStation other) => documentId == other.documentId;

  @override
  int get hashCode => documentId.hashCode;
}
