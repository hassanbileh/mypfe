import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypfe/constants/text_field.dart';

import '../../services/auth/auth_exceptions.dart';
import '../../services/auth/auth_services.dart';
import '../../utilities/dialogs/error_dialog.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _resetPwd() async {
    try {
      await AuthService.firebase().resetPassword(email: _email.text);
      await showErrorDialog(
        context,
        'Verifier vos mails, nous vous avons envoyé un lien de réinitialisation',
      );
    } on UserNotFoundAuthException {
      await showErrorDialog(
        context,
        'Utilisateur introuvable',
      );
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(
        context,
        'Email dèjà utilisé',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Erreur, veuillez entrer un email.',
      );
    } on FirebaseAuthException catch (e) {
      await showErrorDialog(
        context,
        e.message.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[500],
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50.0),
          child: Text(
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            "Reinitialiser",
          ),
        ),
        shadowColor: Colors.lightBlue,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        height: 300,
        width: double.infinity,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings_backup_restore),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    'Entrer votre email ici, nous vous enverrons un lien pour réinitialiser votre mot de passe.'),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email,
                  enableSuggestions: true, //? important for the email
                  autocorrect: false, //? important for the email
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    icon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 74, 44, 156),
                    ),
                    hintText: emailHintText,
                    labelText: emailLabelText,
                  ),
                ),
              ),
              TextButton(
                style: const ButtonStyle(
                    mouseCursor: MaterialStateMouseCursor.clickable),
                onPressed: () => _resetPwd(),
                child: const Text('Réinitialiser le mot de passe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
