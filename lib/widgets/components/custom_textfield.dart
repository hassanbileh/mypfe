import 'package:flutter/material.dart';

typedef OnSubmitted = void Function(String)?;

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Icon? icon;
  final bool isP;
  final TextInputType? kbType;
  final String hintText;
  final String? labelText;
  final OnSubmitted? onSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.labelText,
    required this.onSubmitted,
    required this.isP,
    required this.kbType,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          enableSuggestions: (labelText != null) ? false : true,
          autocorrect: false,
          obscureText: isP,
          onSubmitted: onSubmitted,
          keyboardType: kbType,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            fillColor: Colors.grey.shade100,
            filled: true,
            icon: icon,
            hintText: hintText,
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
