import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final bool isString;
  final String hintText;
  final String labelText;
  final IconData iconData;
  final TextEditingController textController;
  const TextFieldForm({
    super.key,
    required this.textController,
    required this.iconData,
    required this.hintText,
    required this.labelText,
    required this.isString,
  });

  @override
  Widget build(BuildContext context) {
    return (isString) ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textController,
          enableSuggestions: true, //? important for the email
          autocorrect: false, //? important for the email
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
            icon: Icon(
              iconData,
              color: const Color.fromARGB(255, 74, 44, 156),
            ),
            hintText: hintText,
            labelText: labelText,
          ),
        ),
      ) : 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: textController,
          enableSuggestions: true, //? important for the email
          autocorrect: false, //? important for the email
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
            icon: Icon(
              iconData,
              color: const Color.fromARGB(255, 74, 44, 156),
            ),
            hintText: hintText,
            labelText: labelText,
          ),
        ),
      );
  }
}
