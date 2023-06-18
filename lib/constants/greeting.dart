import 'package:flutter/material.dart';

String greeting() {
  String goodMorning = 'Bonjour';
  String goodEven = 'Bonsoir';
  final hour = TimeOfDay.now().hour;
  if (hour <= 12) {
    return goodMorning;
  } else {
    return goodEven;
  }
}
