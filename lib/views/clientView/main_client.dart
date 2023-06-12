
import 'package:flutter/material.dart';

import '../../constants/greeting.dart';

class MainClientPage extends StatefulWidget {
  const MainClientPage({super.key});

  @override
  State<MainClientPage> createState() => _MainClientPageState();
}

class _MainClientPageState extends State<MainClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(greeting()),),
      body: const Center(child: Text('Client Page'),),
    );
  }
}