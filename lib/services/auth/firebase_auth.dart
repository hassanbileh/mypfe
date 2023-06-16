import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mypfe/constants/user_constants.dart';
import 'package:mypfe/services/auth/auth_exceptions.dart';
import 'package:mypfe/services/auth/auth_provider.dart';
import 'package:mypfe/services/auth/auth_user.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';

import '../../firebase_options.dart';

class FirebaseAuthProvider implements AuthProvider {
  final users = FirebaseFirestore.instance.collection(userTable);
  final firebaseService = FirebaseCloudUserStorage();

  // When user register to our platform
  @override
  Future<AuthUser> createClient({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  }) async {
    try {
      //Create user with FirebaseAuth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // add it to users collection in Firebase Cloud
        await firebaseService.createNewClientInCloud(
          email: email,
          nom: nom!,
          telephone: telephone,
          isEmailVerified: false,
        );
        //return an AuthUser
        return AuthUser.fromFirebase(user);
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

// When admin create another admin
  @override
  Future<AuthUser> createAdmin({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  }) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await firebaseService.createNewAdminInCloud(
          email: email,
          nom: nom!,
          telephone: telephone,
          isEmailVerified: false,
        );
        return AuthUser.fromFirebase(user);
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

// When admin create company
  @override
  Future<AuthUser> createCompany({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await firebaseService.createNewCompanyInCloud(
          email: email,
          nom: nom!,
          telephone: telephone,
          isEmailVerified: false,
        );
        return AuthUser.fromFirebase(user);
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

// Get current user
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

//Initialise Firebase
  @override
  Future<void> initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

//Login avec FirebaseAuth
  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      // Si user existe
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      //! Catching FirebaseAuth Errors
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      //! catching any other error different of FirebaseAuth
      throw GenericAuthException();
    }
  }

// Deconnexion
  @override
  Future<void> logOut() async {
    // final googleSignIn = GoogleSignIn();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
      // await googleSignIn.disconnect();
      // await googleSignIn.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

// Envoyer verification email
  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
  
  @override
  Future<void> resetPassword({required String email}) async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email); 
      
    } on FirebaseAuthException {
      throw GenericAuthException();
    }
  }
  @override
  Future<void> delete({required String email}) async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email == email) {
      await user.delete();
    }
  }

  
}
