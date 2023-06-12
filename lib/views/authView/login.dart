import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
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
  final firebaseCloudService = FirebaseCloudStorage();

  @override
  void initState() {
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
      final email = _email.text;
      final password = _password.text;
      await AuthService.firebase().logIn(
        email: email,
        password: password,
      );
      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        // user's email verified
        final role = await FirebaseCloudStorage().getRole(email: email);
        if (role == 'admin') {
          await firebaseCloudService.updateIsEmailVerified(email: email);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(mainAdminRoute, (route) => false);
        } else if (role == 'compagnie') {
          await firebaseCloudService.updateIsEmailVerified(email: email);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(mainCompanyRoute, (route) => false);
        } else {
          await firebaseCloudService.updateIsEmailVerified(email: email);
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
        'User not found',
      );
    } on WrongPasswordAuthException {
      await showErrorDialog(
        context,
        'Wrong password',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Authentication error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Welcome back, you\'ve been missed.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //Icon
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
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
                              hintText: 'Enter your email here',
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
                              hintText: 'Enter your password here',
                              labelText: 'Password',
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forget the password ?',
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
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: OutlinedButton(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () => _submitData(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('You don\'t have an account ?'),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    registerRoute, (route) => false);
                              },
                              child: const Text(
                                'Sign Up',
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
