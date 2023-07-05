import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/constants/ticket_constants.dart';

class CloudTicket {
  final String documentId;
  final String depart;
  final String destination;
  final String jour;
  final String heureDepart;
  final String heureArrive;
  final bool status;
  final String trainNum;
  final String company;
  final String companyEmail;

  const CloudTicket({
    required this.documentId,
    required this.depart,
    required this.destination,
    required this.jour,
    required this.heureDepart,
    required this.heureArrive,
    required this.status,
    required this.trainNum,
    required this.companyEmail,  
    required this.company,
  });

  CloudTicket.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        depart = snapshot.data()[champDepart] as String,
        destination = snapshot.data()[champDestination] as String,
        jour = snapshot.data()[champDate] as String,
        heureDepart = snapshot.data()[champHeureDepart] as String,
        heureArrive = snapshot.data()[champHeureArrive] as String,
        status = snapshot.data()[champStatus] as bool,
        trainNum = snapshot.data()[champTrainNum] as String,
        companyEmail = snapshot.data()[champCompagnieEmail] as String,
        company = snapshot.data()[champCompagnie] as String;
}
