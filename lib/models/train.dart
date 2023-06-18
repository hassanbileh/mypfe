import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/models/classe.dart';

class CloudTrain {
  final String documentId;
  final String numero;
  final String companyEmail;
  final int nbrClasses;
  final Iterable<CloudClasse> classes;
  

  const CloudTrain({
    required this.documentId,
    required this.numero,
    required this.companyEmail,
    required this.nbrClasses,
    required this.classes,
  });

  CloudTrain.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        numero = snapshot.data()['numero'] as String ,
        companyEmail = snapshot.data()['companyEmail'] as String,
        nbrClasses = snapshot.data()['nbr_classes'] as int,
        classes = (snapshot.data()['classes'] as Iterable<CloudClasse>).map((dynamic c) => CloudClasse.fromSnapshot(c as QueryDocumentSnapshot<Map<String, dynamic>>)).toList();


  @override
  bool operator==(covariant CloudTrain other) => documentId == other.documentId;

  @override
  int get hashCode => documentId.hashCode; 
}
