import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/constants/text_field.dart';
import 'package:mypfe/constants/user_constants.dart';
// import 'package:sany/enums/role_enums.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';

import '../../services/auth/auth_exceptions.dart';

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
        'Mot de passe incorrecte',
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

                  //Welcome Title
                  Text(
                    'Welcome back to',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  //logo
                  SizedBox(
                    height: 90,
                    width: 250,
                    child: Image.asset(
                      'assets/images/pfe-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  const Icon(
                    Icons.lock,
                    size: 50,
                  ),

                  Container(
                    margin: const EdgeInsets.all(3),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Email textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _email,
                            enableSuggestions: true, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
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

                        //Password textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _password,
                            obscureText: true, // important for the password
                            enableSuggestions:
                                false, // important for the password
                            autocorrect: false,
                            onSubmitted: (_) =>
                                _submitData(), // important for the password
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              icon: const Icon(
                                Icons.password,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              hintText: passwordHintText,
                              labelText: passwordLabelText,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(resetPassordRoute);
                              },
                              child: Text(
                                'mot de passe oublié ?',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          width: 330,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              
                              colors: <Color>[
                                Color.fromARGB(255, 113, 68, 239),
                                Color.fromARGB(255, 183, 128, 255),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: OutlinedButton(
                            child: const Text(
                              loginButtonText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => _submitData(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('vous n\'avez pas un compte ?'),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    registerRoute, (route) => false);
                              },
                              child: const Text(
                                registerButtonText,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 74, 44, 156)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
