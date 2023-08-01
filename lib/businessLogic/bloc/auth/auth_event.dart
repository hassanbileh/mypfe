import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin(
    this.email,
    this.password,
  );
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventCreateAccount extends AuthEvent {
  final String email;
  final String? nom;
  final String password;
  final int? telephone;

  const AuthEventCreateAccount(
    this.email,
    this.nom,
    this.telephone,
    this.password,
  );
}

class AuthEventResetPassword extends AuthEvent{
  final String email;
  const AuthEventResetPassword(this.email);
}

class AuthEventDeleteAccount extends AuthEvent {
  final String email;
  const AuthEventDeleteAccount(this.email);
}

class AuthEventShouldResetPassword extends AuthEvent {
  const AuthEventShouldResetPassword();
}

