import 'package:flutter/material.dart';

class MainTicketView extends StatefulWidget {
  const MainTicketView({super.key});

  @override
  State<MainTicketView> createState() => _MainTicketViewState();
}

class _MainTicketViewState extends State<MainTicketView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Text('Tickets View'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add_road_rounded),)
    );
  }
}
