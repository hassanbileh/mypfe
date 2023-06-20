// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mypfe/constants/text_field.dart';

typedef ConfirmCallBack = void Function();
typedef LittleCallBack = void Function();

class UserForm extends StatelessWidget {
  final IconData icon;
  final ConfirmCallBack confirm;
  final ConfirmCallBack? littleButton;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController nom;
  final TextEditingController telephone;
  final String? buttonText;
  final String? littleTitle;
  final String? littleButtonText;

  const UserForm({
    super.key,
    required this.icon,
    required this.email,
    required this.nom,
    required this.telephone,
    required this.password,
    required this.confirmPassword,
    required this.buttonText,
    required this.confirm,
    required this.littleTitle,
    required this.littleButton, 
    required this.littleButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                   //Welcome Title
                  Text(
                    'Welcome to',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),

                  //logo
                  SizedBox(
                    height: 70,
                    width: 220,
                    child: Image.asset(
                      'assets/images/pfe-logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  const Icon(
                    Icons.person,
                    size: 50,
                  ),

                  Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Email textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: email,
                            enableSuggestions: true, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
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

                        // Nom textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: nom,
                            enableSuggestions: true, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              icon: const Icon(
                                Icons.person_pin_rounded,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              hintText: nomHintText,
                              labelText: nomLabelText,
                            ),
                          ),
                        ),

                        // Telephone textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: telephone,
                            enableSuggestions: false, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              icon: const Icon(
                                Icons.phone,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              hintText: telHintText,
                              labelText: telLabelText, 
                            ),
                          ),
                        ),

                        //Password textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: password,
                            obscureText: true, // important for the password
                            enableSuggestions:
                                false, // important for the password
                            autocorrect: false, // important for the password
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
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
                        //Confirm Password textField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: confirmPassword,
                            obscureText: true, // important for the password
                            enableSuggestions:
                                false, // important for the password
                            autocorrect: false,  // important for the password
                            onSubmitted: (_) => confirm,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              icon: const Icon(
                                Icons.password,
                                color: Color.fromARGB(255, 74, 44, 156),
                              ),
                              hintText: confirmPswdHintText,
                              labelText: confirmPswdLabelText,
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
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 113, 68, 239),
                                Color.fromARGB(255, 183, 128, 255),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: OutlinedButton(
                            onPressed: confirm,
                            child: Text(
                              buttonText!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(littleTitle!),
                            TextButton(
                              onPressed: littleButton!,
                              child: Text(
                                littleButtonText!,
                                style: const TextStyle(
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
      );
  }
}
