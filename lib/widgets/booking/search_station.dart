import 'package:flutter/material.dart';

class SearchStation extends StatelessWidget {
  final IconData icon;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  final String value;
  final String hintText;

  const SearchStation({
    super.key,
    required this.icon,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 74, 44, 156),
        ),
        const SizedBox(
          width: 10.0,
        ),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.7,
          child: DropdownButton(
            elevation: 5,
            isExpanded: true,
            items: items,
            onChanged: onChanged,
            value: value,
            hint: Text(hintText),
          ),
        ),
      ],
    );
  }
}
