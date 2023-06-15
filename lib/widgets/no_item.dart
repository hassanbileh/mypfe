import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  final String title;
  const NoItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30,),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        SizedBox(
          height: 300,
          width: 400,
          child: Image.asset('lib/assets/images/waiting.png'),
        ),
      ],
    );
  }
}
