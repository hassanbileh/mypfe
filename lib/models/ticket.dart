import 'package:cloud_firestore/cloud_firestore.dart';

class CloudTicket {
  final String documentId;
  final String depart;
  final String destination;
  final DateTime jour;
  final DateTime heureDepart;
  final DateTime heureArrive;
  final bool status;
  final String trainId;
  final String companyEmail;

  const CloudTicket( {
    required this.documentId,
    required this.depart,
    required this.destination,
    required this.jour,
    required this.heureDepart,
    required this.heureArrive,
    required this.status,
    required this.trainId,
    required this.companyEmail,
  });

  CloudTicket.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        depart = snapshot.data()['depart'] as String,
        destination = snapshot.data()['destination'] as String,
        jour = snapshot.data()['jour'] as DateTime,
        heureDepart = snapshot.data()['heureDepart'] as DateTime,
        heureArrive = snapshot.data()['heureArrive'] as DateTime,
        status = snapshot.data()['status'] as bool,
        trainId = snapshot.data()['trainId'] as String,
        companyEmail = snapshot.data()['companyEmail'] as String;
}
