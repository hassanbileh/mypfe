import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/services/auth/auth_exceptions.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';

import '../../services/auth/auth_services.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmpassword;
  late final TextEditingController _nom;
  late final TextEditingController _telephone;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmpassword = TextEditingController();
    _nom = TextEditingController();
    _telephone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmpassword.dispose();
    _nom.dispose();
    _telephone.dispose();
    super.dispose();
  }

  void _submitData() async {
    try {
      final email = _email.text;
      final password = _password.text;
      final confirmPassword = _confirmpassword.text;
      final nom = _nom.text;
      final telephone = int.parse(_telephone.text);
      if (email.isEmpty ||
          password.isEmpty ||
          nom.isEmpty ||
          _telephone.text.isEmpty ||
          confirmPassword.isEmpty) {
        return showErrorDialog(context, 'Make sure you filled all requirements');
      }
      await AuthService.firebase().createClient(
        email: email,
        nom: nom,
        password: password,
        telephone: telephone,
      );
      await AuthService.firebase().sendEmailVerification();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
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
                    'Welcome to Sany, create new account.',
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

                        // Nom textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _nom,
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
                                Icons.person_pin_rounded,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              hintText: 'Enter your name here',
                            ),
                          ),
                        ),

                        // Telephone textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _telephone,
                            enableSuggestions: false, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              icon: const Icon(
                                Icons.phone,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              hintText: 'Enter your phone number here',
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
                        //Confirm Password textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _confirmpassword,
                            obscureText: true, // important for the password
                            enableSuggestions:
                                false, // important for the password
                            autocorrect: false, // important for the password
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
                              hintText: 'Confirm your password',
                              labelText: ' Confirm Password',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
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
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account ?'),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    loginRoute, (route) => false);
                              },
                              child: const Text(
                                'Login',
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
