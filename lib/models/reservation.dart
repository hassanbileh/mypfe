import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/constants/reservation_constants.dart';

class CloudReservation {
  const CloudReservation(
      {required this.documentId,
      required this.date,
      required this.nbrPassagers,
      required this.prixService,
      required this.prixTotal,
      required this.status,
      required this.ticketId,
      required this.classe,
      required this.client});

  final String documentId;
  final String? date;
  final int? nbrPassagers;
  final double? prixService;
  final double? prixTotal;
  final bool? status;
  final String ticketId;
  final String classe;
  final String client;

  CloudReservation.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        date = snapshot.data()[champDateReservation] as String,
        nbrPassagers = snapshot.data()[champNbrPassagers] as int,
        prixService = snapshot.data()[champPrixService] as double,
        prixTotal = snapshot.data()[champPrixTotal] as double,
        status = snapshot.data()[champStatus] as bool,
        ticketId = snapshot.data()[champTicket] as String,
        classe = snapshot.data()[champClasse] as String,
        client = snapshot.data()[createdBy] as String;

  

  @override
  bool operator ==(covariant CloudReservation other) => documentId == other.documentId;

  @override
  int get hashCode => documentId.hashCode;
}
