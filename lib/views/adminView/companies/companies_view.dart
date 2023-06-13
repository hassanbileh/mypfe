import 'package:flutter/material.dart';

class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text(
        'Company View',
      ),
    );
  }
}
