import 'package:flutter/material.dart';

typedef OnPressed = void Function()?;

class GradientButton extends StatelessWidget {
  final String buttonText;
  final OnPressed onPressed;
  final double height;
  final double width;

  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            Color.fromARGB(255, 113, 68, 239),
            Color.fromARGB(255, 183, 128, 255),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
