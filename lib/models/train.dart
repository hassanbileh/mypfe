import 'package:cloud_firestore/cloud_firestore.dart';

class CloudTrain {
  final String documentId;
  final String numero;
  final String companyEmail;
  final int nbrClasses;
  

  const CloudTrain({
    required this.documentId,
    required this.numero,
    required this.companyEmail,
    required this.nbrClasses,
  });

  CloudTrain.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        numero = snapshot.data()['numero'] as String,
        companyEmail = snapshot.data()['compagnieEmail'] as String,
        nbrClasses = snapshot.data()['nbr_clases'] as int;



}
