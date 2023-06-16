import 'package:mypfe/services/auth/auth_provider.dart';
import 'package:mypfe/services/auth/auth_user.dart';
import 'package:mypfe/services/auth/firebase_auth.dart';

class AuthService implements AuthProvider {
  AuthService(this.provider);
  final AuthProvider provider;

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialise() => provider.initialise();

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<AuthUser> createClient({
    required String email,
    required String? nom,
    required String password,
    required int? telephone,
  }) =>
      provider.createClient(
        email: email,
        nom: nom,
        password: password,
        telephone: telephone,
      );

  @override
  Future<AuthUser> createAdmin(
          {required String email,
          required String? nom,
          required String password,
          required int? telephone}) =>
      provider.createAdmin(
        email: email,
        nom: nom,
        password: password,
        telephone: telephone,
      );

  @override
  Future<AuthUser> createCompany(
          {required String email,
          required String? nom,
          required String password,
          required int? telephone}) =>
      provider.createCompany(
        email: email,
        nom: nom,
        password: password,
        telephone: telephone,
      );

  @override
  Future<void> resetPassword({required String email}) => provider.resetPassword(email: email);
  
  @override
  Future<void> delete({required String email}) => provider.delete(email: email);
}
