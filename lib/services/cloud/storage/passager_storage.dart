import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/constants/reservation_constants.dart';
import 'package:mypfe/models/passager.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudPassagerStorage {
  FirebaseCloudPassagerStorage._sharedInstance();
  static final _shared = FirebaseCloudPassagerStorage._sharedInstance();
  factory FirebaseCloudPassagerStorage() => _shared;

  CollectionReference passagers =
      FirebaseFirestore.instance.collection('passagers');

  Future<CloudPassager> createNewPassenger({
    required String nom,
    required String nationalite,
    required String passeport,
    required int age,
    required String genre,
    required String client,
    required String ticket,
    required String reservation,
    required String classe,
  }) async {
    try {
      final doc = await passagers.add({
        nomPassager: nom,
        nationalitePassager: nationalite,
        passportPassager: passeport,
        agePassager: age,
        genrePassager: genre,
        creePar: client,
        ticketPassager: ticket,
        classePassager: classe,
        reservationPassager: reservation,
      });

      final fetchedPassenger = await doc.get();

      return CloudPassager(
        documentId: fetchedPassenger.id,
        nom: nom,
        nationalite: nationalite,
        age: age,
        genre: genre,
        passeport: passeport,
        ticket: ticket,
        reservation: reservation,
        classe: classe,
        creePar: creePar,
      );
    } catch (e) {
      throw CouldNotCreatePassengerException();
    }
  }

  Future<void> deletePassenger({required String documentId}) async{
    try {
      await passagers.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeletePassengerException();
    }
  }

  //Get all stations
  Future<Iterable<CloudPassager>> getAllPassengers({required String client}) async{
    try {
      final gotPassengers = await FirebaseFirestore.instance
          .collection('passagers')
          .where(
            creePar,
            isEqualTo: client,
          )
          .get()
          .then(
            // onError: (_) => CloudNotGetAllNotesException(),
            (value) => value.docs.map((doc) => CloudPassager.fromSnapshot(doc)),
          );
      return gotPassengers;
    } catch (e) {
      throw CouldNotReadPassengerException();
    }
  }

  Stream<Iterable<CloudPassager>> getPassengers({required String client}) {
    final gotPassengers = passagers.snapshots().map((event) => event.docs
        .map((doc) => CloudPassager.fromSnapshot(
            doc as QueryDocumentSnapshot<Map<String, dynamic>>))
        .where((ticket) => ticket.creePar == client));

    return gotPassengers;
  }
}
