import 'package:flutter/material.dart';

import '../../constants/greeting.dart';
import '../../constants/routes.dart';
import '../../services/auth/auth_services.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({super.key});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50.0),
          child: Text(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            greeting(),
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
              const Icon(Icons.dangerous),
              const Text(
                  'We\'ve send you a message to your email, please check in order tou verify your account'),
              const Text(
                  'If you\'ve not received any message, click the button below'),
              TextButton(
                style: const ButtonStyle(
                    mouseCursor: MaterialStateMouseCursor.clickable),
                onPressed: () async {
                  await AuthService.firebase().sendEmailVerification();
                },
                child: const Text('Send email verification'),
              ),
              TextButton(
                onPressed: () async {
                  AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text('Restart'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
