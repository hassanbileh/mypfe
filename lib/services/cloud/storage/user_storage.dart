import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/constants/user_constants.dart';

import '../exceptions/user_cloud_exceptions.dart';
import '../../../models/users.dart';

class FirebaseCloudUserStorage {
  final CollectionReference users =
      FirebaseFirestore.instance.collection(userTable);
  final db = FirebaseFirestore.instance;

  //? Make a singleton
  // 1- create a private constructor
  FirebaseCloudUserStorage._sharedInstance();

  // 2- create a factory constructor who talk with a static final variable
  factory FirebaseCloudUserStorage() => _shared;

  // 3- create the static final var who talk with the private constructor in 1
  static final _shared = FirebaseCloudUserStorage._sharedInstance();

// Create new client in firestore
  Future<CloudUser> createNewClientInCloud(
      {
      required String email,
      required String nom,
      required int? telephone,
      required bool? isEmailVerified}) async {
    final document = await users.add({
      champEmail: email,
      champNom: nom,
      champRole: client,
      champTelephone: telephone,
      champIsEmailVerified: isEmailVerified,
    });
    final fetchedClient = await document.get();
    return CloudUser(
        documentId: fetchedClient.id,
        email: email,
        nom: nom,
        telephone: telephone,
        role: client,
        isEmailVerified: isEmailVerified!);
  }

// Create new company
  Future<CloudUser> createNewCompanyInCloud(
      {
      required String email,
      required String nom,
      required int? telephone,
      required bool? isEmailVerified}) async {
    final document = await users.add({
      champEmail: email,
      champNom: nom,
      champRole: partenaire,
      champTelephone: telephone,
      champIsEmailVerified: isEmailVerified,
    });
    final fetchedCompany = await document.get();
    return CloudUser(
      documentId: fetchedCompany.id,
      email: email,
      nom: nom,
      telephone: telephone,
      role: partenaire,
      isEmailVerified: isEmailVerified!,
    );
  }

// Create new admin in the firestore
  Future<CloudUser> createNewAdminInCloud(
      {
      required String email,
      required String nom,
      required int? telephone,
      required bool? isEmailVerified}) async {
    final document = await users.add({
      champEmail: email,
      champNom: nom,
      champRole: owner,
      champTelephone: telephone,
      champIsEmailVerified: isEmailVerified,
    });
    final fetchedCompany = await document.get();
    return CloudUser(
      documentId: fetchedCompany.id,
      email: email,
      nom: nom,
      telephone: telephone,
      role: owner,
      isEmailVerified: isEmailVerified!,
    );
  }

// Get User
  Future<CloudUser> getUser({required String email}) async {
    try {
      final gotUser = await FirebaseFirestore.instance
          .collection(userTable)
          .where(
            champEmail,
            isEqualTo: email,
          )
          .get();
      if (gotUser.docs.isNotEmpty) {
        final firstUser = gotUser.docs.first;
        final user = CloudUser.fromSnapshot(firstUser);
        return user;
      } else {
        throw CouldNotFindUser;
      }
    } catch (e) {
      throw CouldNotFindUser;
    }
  }

//Get User's Role
  Future<String> getRole({required String email}) async {
    try {
      final gotUser = await FirebaseFirestore.instance
          .collection(userTable)
          .where(
            champEmail,
            isEqualTo: email,
          )
          .get()
          .then((value) => value.docs.first);
      final role = gotUser[champRole] as String;
      return role;
    } catch (e) {
      throw CouldNotFindRoleException();
    }
  }

  Future<void> updateIsEmailVerified({required String email}) async {
    try {
      final gotUser = await FirebaseFirestore.instance
          .collection(userTable)
          .where(
            champEmail,
            isEqualTo: email,
          )
          .get();
      if (gotUser.docs.isNotEmpty) {
        final docId = gotUser.docs.first.id;
        await db
            .collection(userTable)
            .doc(docId)
            .update({champIsEmailVerified: true});
      }
    } catch (e) {
      throw CouldNotUpdateVerificationEmailException();
    }
  }



}
