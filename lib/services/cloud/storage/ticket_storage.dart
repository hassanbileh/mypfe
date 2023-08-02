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
    required String compagnieEmail,
    required String company,
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
        champCompagnieEmail: compagnieEmail,
        champCompagnie: company,
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
        company: company,
        companyEmail: compagnieEmail,
      );
    } catch (e) {
      throw CouldNotCreateTicketException();
    }
  }

  Future<void> updateTicket({
    required String documentId,
    required String depart,
    required String destination,
    required String trainNum,
    required String date,
    required String heureDepart,
    required String heureArrive,
    required bool status,
  }) async {
    try {
      await ticketCollection.doc(documentId).update({
        champDepart: depart,
        champDestination: destination,
        champDate: date,
        champHeureDepart: heureDepart,
        champHeureArrive: heureArrive,
        champTrainNum: trainNum,
        champStatus: status,
      });
    } catch (e) {
      throw CouldNotUpdateTicketException();
    }
  }

  Future<void> deleteTicket({required String documentId}) async {
    try {
      await ticketCollection.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteTicketException();
    }
  }

  Future<CloudTicket> getTicket(
      {required String documentId}) async{
    final gotTicket = await FirebaseFirestore.instance.collection('tickets').doc(documentId).get().then((value) => value);
    final ticket = CloudTicket.fromDocument(gotTicket);

    return ticket;
  }

  Stream<Iterable<CloudTicket>> getAllTicketsByCompanyEmail(
      {required String companyEmail}) {
    final gotTickets = ticketCollection.snapshots().map((event) => event.docs
        .map((doc) => CloudTicket.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>))
        .where((ticket) => ticket.companyEmail == companyEmail));

    return gotTickets;
  }

  Stream<Iterable<CloudTicket>> getTicketByStationsAndDate({
    required String depart,
    required String destination,
    required String date,
  }) {
    final queryTickets = ticketCollection.snapshots().map((event) => event.docs
            .map((doc) => CloudTicket.fromSnapshot(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            .where((ticket) {
          return ticket.depart.toLowerCase() == depart.toLowerCase() &&
              ticket.destination.toLowerCase() == destination.toLowerCase() &&
              ticket.jour == date;
        }));
    return queryTickets;
  }

  
}
