

import 'package:mypfe/services/auth/auth_user.dart';

abstract class AuthProvider {

  Future<void> initialise();

//
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });


  AuthUser? get currentUser;

  Future<AuthUser> createClient({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  });

  Future<AuthUser> createCompany({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  });

  Future<AuthUser> createAdmin({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  });

  Future<void> sendEmailVerification();

  Future<void> logOut();

  Future <void> resetPassword({required String email});

  Future<void> delete({required String email});

}