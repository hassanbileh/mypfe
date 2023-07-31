import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/constants/user_constants.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/widgets/auth/login_header.dart';

import '../../services/auth/auth_exceptions.dart';
import '../../widgets/auth/login_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final FirebaseCloudUserStorage _firebaseCloudService;

  @override
  void initState() {
    _firebaseCloudService = FirebaseCloudUserStorage();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submitData() async {
    try {
      final email = _email.text.toLowerCase();
      final password = _password.text;
      await AuthService.firebase().logIn(
        email: email,
        password: password,
      );
      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        // user's email verified
        final role = await FirebaseCloudUserStorage().getRole(email: email);
        if (role == owner) {
          await _firebaseCloudService.updateIsEmailVerified(email: email);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(mainAdminRoute, (route) => false);
        } else if (role == partenaire) {
          await _firebaseCloudService.updateIsEmailVerified(email: email);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(mainCompanyRoute, (route) => false);
        } else {
          await _firebaseCloudService.updateIsEmailVerified(email: email);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(mainClientRoute, (route) => false);
        }
      } else {
        // user email is NOT veerified
        await AuthService.firebase().sendEmailVerification();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
      }
    } on UserNotFoundAuthException {
      await showErrorDialog(
        context,
        'Utilisateur introuvable',
      );
    } on WrongPasswordAuthException {
      await showErrorDialog(
        context,
        'Informations Incorrectes',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Erreur d\'authentification',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  
                  const SizedBox(
                    height: 15,
                  ),

                  // Header
                  const HeaderLogin(),

                  //Body
                  LoginBody(
                    email: _email,
                    password: _password,
                    onSubmitted: (_) => _submitData(),
                    onPressed: _submitData,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
