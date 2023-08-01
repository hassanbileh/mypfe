import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:mypfe/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadinText;
  const AuthState({
    this.loadinText = 'Please wait a moment',
    required this.isLoading,
  });
}

class AuthStateUninitialise extends AuthState {
  const AuthStateUninitialise({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({required this.exception, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLogOut extends AuthState {
  final Exception? exception;

  const AuthStateLogOut({
    required this.exception,
    String? loadingText,
    required super.isLoading,
  }) : super(loadinText: loadingText);
}

class AuthStateLoading extends AuthState with EquatableMixin {
  final Exception? exception;

  const AuthStateLoading({
    required this.exception,
    String? loadingText,
    required super.isLoading,
  }) : super(loadinText: loadingText);

  @override
  List<Object?> get props => [
        exception,
        isLoading,
        loadinText,
      ];
}

class AuthStateRegister extends AuthState {
  final Exception? exception;
  const AuthStateRegister({
    required this.exception,
    required super.isLoading,
    String? loadinText,
  }) : super(loadinText: loadinText);
}

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification({required super.isLoading});
}

