import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudTicketStorage {
  FirebaseCloudTicketStorage._sharedInstance();
  static final _shared = FirebaseCloudTicketStorage._sharedInstance();
  factory FirebaseCloudTicketStorage() => _shared;

  CollectionReference ticketCollection = FirebaseFirestore.instance.collection('tickets');

  
}