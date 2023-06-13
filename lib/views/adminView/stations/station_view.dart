import 'package:flutter/material.dart';

class StationView extends StatefulWidget {
  const StationView({super.key});

  @override
  State<StationView> createState() => _StationViewState();
}

class _StationViewState extends State<StationView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text(
        'Station View',
      ),
    );
  }
}