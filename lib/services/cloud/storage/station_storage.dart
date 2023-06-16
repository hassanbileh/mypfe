import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/constants/station_constants.dart';
import 'package:mypfe/models/station.dart';
import 'package:mypfe/services/cloud/exceptions/user_cloud_exceptions.dart';

class FirebaseCloudStationStorage {
  FirebaseCloudStationStorage._sharedInstance();
  static final _shared = FirebaseCloudStationStorage._sharedInstance();
  factory FirebaseCloudStationStorage() => _shared;

  final CollectionReference stations =
      FirebaseFirestore.instance.collection(stationTable);

//Create station
  Future<CloudStation> createNewStation({
    required String adminEmail,
  }) async {
    try {
      final document = await stations.add({
        champAdminEmail: adminEmail,
        champNumero: '',
        champNom: '',
        champVille: '',
      });
      final fetchedStation = await document.get();

      return CloudStation(
        documentId: fetchedStation.id,
        numero: '',
        nom: '',
        ville: '',
        adminEmail: adminEmail,
      );
    } catch (e) {
      throw CouldNotCreateStationException();
    }
  }

//Delete station by document id
  Future<void> deleteStation({required String documentId}) async {
    try {
      await stations.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteStationException();
    }
  }

//Modify station's number,name and ville by document id
  Future<void> updateStation({
    required String documentId,
    required String numero,
    required String nom,
    required String ville,
  }) async {
    try {
      await stations.doc(documentId).update({
        champNumero: numero,
        champNom: nom,
        champVille: ville,
      });
    } catch (e) {
      throw CouldNotUpdateStationException();
    }
  }

//Get all stations
  Stream<Iterable<CloudStation>> getAllStations() {
    try {
      final allStations = FirebaseFirestore.instance
          .collection(stationTable)
          .snapshots()
          .map((event) =>
              event.docs.map((doc) => CloudStation.fromSnapshot(doc)));
      return allStations;
    } catch (e) {
      throw CouldNotGetStationException();
    }
  }
}
