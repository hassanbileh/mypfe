import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/services/auth/auth_exceptions.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/widgets/register_user_form.dart';

import '../../constants/text_field.dart';
import '../../services/auth/auth_services.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _nom;
  late final TextEditingController _telephone;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _nom = TextEditingController();
    _telephone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _nom.dispose();
    _telephone.dispose();
    super.dispose();
  }

  void _submitData() async {
    try {
      final email = _email.text.trim();
      final password = _password.text.trim();
      final confirmPassword = _confirmPassword.text.trim();
      final nom = _nom.text.trim();
      final telephone = int.parse(_telephone.text.trim());
      if (email.isEmpty ||
          password.isEmpty ||
          nom.isEmpty ||
          confirmPassword.isEmpty) {
        await showErrorDialog(context, 'Make sure you filled all requirements');
      } else {
        await AuthService.firebase().createClient(
          email: email,
          nom: nom,
          password: password,
          telephone: telephone,
        );
        await AuthService.firebase().sendEmailVerification();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
      }
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(
        context,
        'Email already in use',
      );
    } on InvalidEmailAuthException {
      await showErrorDialog(
        context,
        'Invalid email',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Make sure all fields are provided',
      );
    } on UserNotLoggedInAuthException {
      await showErrorDialog(
        context,
        'failed to resgister',
      );
    } on FormatException {
      await showErrorDialog(
        context,
        'Make sure all fields are provided',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserForm(
        title: 'Bienvenue à Sany, créer un compte ici.',
        icon: Icons.person,
        email: _email,
        nom: _nom,
        telephone: _telephone,
        password: _password,
        confirmPassword: _confirmPassword,
        buttonText: registerButtonText,
        confirm: _submitData,
        littleTitle: aUnCompteText,
        littleButton: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(loginRoute, (route) => false);
        },
        littleButtonText: loginButtonText,
      ),
    );
  }
}
