import 'package:flutter/material.dart';

class ClassOnTicket extends StatelessWidget {
  final String className;
  final double height;
  final double width;
  final bool isAvailable;

  const ClassOnTicket({
    super.key,
    required this.className,
    required this.height,
    required this.width,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return (isAvailable)
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: const Color.fromARGB(255, 22, 231, 130)),
                color: const Color.fromARGB(255, 22, 231, 130).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(className),
                  ),
                   const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      "Libre",
                      style: TextStyle(fontSize: 8, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: Color.fromARGB(255, 233, 115, 104)),
                color: const Color.fromARGB(255, 231, 39, 22).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(className),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Text(
                      "Occupé",
                      style: TextStyle(fontSize: 8, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
