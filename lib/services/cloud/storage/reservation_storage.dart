import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mypfe/constants/reservation_constants.dart';
import 'package:mypfe/models/reservation.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

final formatter = DateFormat.yMMMd();

class FirebaseCloudReservationStorage {
  FirebaseCloudReservationStorage._sharedInstance();

  static final _shared = FirebaseCloudReservationStorage._sharedInstance();

  factory FirebaseCloudReservationStorage() => _shared;

  CollectionReference bookCollection =
      FirebaseFirestore.instance.collection('reservations');

  Future<CloudReservation> createNewReservation(
      {required String ticket,
      required String classe,
      required String client,
      }) async {
    try {
      final newBooking =
          await bookCollection.add({
        champDateReservation: '',
        champNbrPassagers: 1,
        champStatus: false,
        champPrixService: 200,
        champPrixTotal: 0,
        champTicket: ticket,
        champClasse: classe,
        createdBy: client,
      });
      final fetchedBooking = await newBooking.get();
      return CloudReservation(
        documentId: fetchedBooking.id,
        date: formatter.format(DateTime.now()),
        nbrPassagers: 1,
        prixService: 200,
        prixTotal: 0,
        status: false,
        ticketId: ticket,
        classe: classe,
        client: client,
      );
    } catch (e) {
      throw CouldNotCreateBookingException();
    }
  }

  Future<void> updateReservationByAddingPassengers({
    required String documentId,
    required int nbrPassagers,
  }) async{
    
  }

  Future<void> deleteReservation({required String documentId}) async{
    try {
      await bookCollection.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteBookingException();
    }
  }
}
