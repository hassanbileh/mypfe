import 'package:flutter/material.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
      ],
    );
  }
}
