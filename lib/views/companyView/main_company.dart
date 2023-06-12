
import 'package:flutter/material.dart';

import '../../constants/greeting.dart';

class MainCompanyPage extends StatefulWidget {
  const MainCompanyPage({super.key});

  @override
  State<MainCompanyPage> createState() => _MainCompanyPageState();
}

class _MainCompanyPageState extends State<MainCompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(greeting()),),
      body: const Center(child: Text('Admin Page'),),
    );
  }
}