import 'package:cloud_firestore/cloud_firestore.dart';

class CloudTicket {
  final String documentId;
  final String depart;
  final String destination;
  final String jour;
  final String heureDepart;
  final String heureArrive;
  final bool status;
  final String trainNum;
  final String companyEmail;

  const CloudTicket( {
    required this.documentId,
    required this.depart,
    required this.destination,
    required this.jour,
    required this.heureDepart,
    required this.heureArrive,
    required this.status,
    required this.trainNum,
    required this.companyEmail,
  });

  CloudTicket.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        depart = snapshot.data()['depart'] as String,
        destination = snapshot.data()['destination'] as String,
        jour = snapshot.data()['jour'] as String,
        heureDepart = snapshot.data()['heureDepart'] as String,
        heureArrive = snapshot.data()['heureArrive'] as String,
        status = snapshot.data()['status'] as bool,
        trainNum = snapshot.data()['trainId'] as String,
        companyEmail = snapshot.data()['companyEmail'] as String;
}
