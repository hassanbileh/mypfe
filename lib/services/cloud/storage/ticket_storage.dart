import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/ticket.dart';
import 'package:mypfe/constants/ticket_constants.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudTicketStorage {
  FirebaseCloudTicketStorage._sharedInstance();
  static final _shared = FirebaseCloudTicketStorage._sharedInstance();
  factory FirebaseCloudTicketStorage() => _shared;

  CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  Future<CloudTicket> createNewTicket({
    required String companyEmail,
    required String depart,
    required String destination,
    required String trainNum,
    required String date,
    required String heureDepart,
    required String heureArrive,
    required bool status,
  }) async {
    try {
      final document = await ticketCollection.add({
        champDepart: depart,
        champDestination: destination,
        champTrainNum: trainNum,
        champDate: date,
        champHeureDepart: heureDepart,
        champHeureArrive: heureArrive,
        champCompagnieEmail: companyEmail,
        champStatus: status,
      });
      final fetchedTicket = await document.get();

      return CloudTicket(
        documentId: fetchedTicket.id,
        depart: depart,
        destination: destination,
        jour: date,
        heureDepart: heureDepart,
        heureArrive: heureArrive,
        status: status,
        trainNum: trainNum,
        companyEmail: companyEmail,
      );
    } catch (e) {
      throw CouldNotCreateTicketException();
    }
  }
}
