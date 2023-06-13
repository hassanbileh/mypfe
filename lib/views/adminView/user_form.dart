// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

typedef ConfirmCallBack = void Function();

class UserForm extends StatelessWidget {
  final String title;
  final ConfirmCallBack confirm;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController nom;
  final TextEditingController telephone;

  const UserForm({
    super.key,
    required this.title,
    required this.email,
    required this.nom,
    required this.telephone,
    required this.password,
    required this.confirmPassword,
    required this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  hintText: 'Enter email here',
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
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.person_pin_rounded,
                    color: Color.fromARGB(255, 74, 44, 156),
                  ),
                  hintText: 'Enter name here',
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
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 74, 44, 156),
                  ),
                  hintText: 'Enter phone number here',
                ),
              ),
            ),

            //Password textField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password,
                obscureText: true, // important for the password
                enableSuggestions: false, // important for the password
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
                  hintText: 'Enter password here',
                  labelText: 'Password',
                ),
              ),
            ),

            //Confirm Password textField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirmPassword,
                obscureText: true, // important for the password
                enableSuggestions: false, // important for the password
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
                  hintText: 'Confirm password',
                  labelText: ' Confirm Password',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            
            // Save Button
            Container(
              height: 60,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: OutlinedButton(
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => confirm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
