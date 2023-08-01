import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../constants/text_field.dart';
import '../components/gradient_button.dart';
import '../components/custom_textfield.dart';

typedef OnSubmitted = void Function(String)?;
typedef OnPressed = void Function()?;

class LoginBody extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final OnSubmitted? onSubmitted;
  final OnPressed onPressed;
  const LoginBody({
    super.key,
    required this.email,
    required this.password,
    required this.onSubmitted,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Email textField
          CustomTextField(
            controller: email,
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 74, 44, 156),
            ),
            hintText: "Entrer votre email ici",
            labelText: "Email",
            onSubmitted: null,
            isP: false, kbType: TextInputType.emailAddress,
          ),

          //Password textfield
          CustomTextField(
            controller: password,
            icon: const Icon(
              Icons.password,
              color: Color.fromARGB(255, 74, 44, 156),
            ),
            hintText: "Entrer votre mot de passe",
            labelText: "Mot de passe",
            onSubmitted: onSubmitted,
            isP: true, kbType: TextInputType.visiblePassword,
          ),

          //Mot de passe oublié
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(resetPassordRoute);
                },
                child: Text(
                  'mot de passe oublié ?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          // connexion
          GradientButton(
            buttonText: loginButtonText,
            onPressed: onPressed,
            height: 60.0,
            width: 330.0,
          ),

          const SizedBox(
            height: 30,
          ),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('vous n\'avez pas un compte ?'),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text(
                  registerButtonText,
                  style: TextStyle(color: Color.fromARGB(255, 74, 44, 156)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
