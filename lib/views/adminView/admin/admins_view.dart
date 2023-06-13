import 'package:flutter/material.dart';

class AdminsView extends StatefulWidget {
  const AdminsView({super.key});

  @override
  State<AdminsView> createState() => _AdminsViewState();
}

class _AdminsViewState extends State<AdminsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text(
        'Admins View',
      ),
    );
  }
}