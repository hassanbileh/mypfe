import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/constants/user_constants.dart';

class CloudUser {
  final String documentId;
  final String email;
  final String? nom;
  final int? telephone;
  final String role;
  final bool isEmailVerified;

  const CloudUser({
    required this.documentId,
    required this.email,
    required this.nom,
    required this.telephone,
    required this.role,
    required this.isEmailVerified,
  });

  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        email = snapshot.data()[champEmail] as String,
        nom = snapshot.data()[champNom] as String,
        telephone = snapshot.data()[champTelephone] as int,
        role = snapshot.data()[champRole] as String,
        isEmailVerified = snapshot.data()[champIsEmailVerified] as bool;
  Map<String, dynamic> toMap() {
    return {
      champEmail: email,
      champNom: nom,
      champTelephone: telephone,
      champRole: role,
      champIsEmailVerified: isEmailVerified,
    };
  }

  @override
  bool operator ==(covariant CloudUser other) => documentId == other.documentId;

  @override
  int get hashCode => documentId.hashCode;
}
