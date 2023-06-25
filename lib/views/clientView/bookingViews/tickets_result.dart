import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/views/companyView/tickets/ticket_item.dart';

class TicketsResults extends StatefulWidget {
  const TicketsResults({super.key});

  @override
  State<TicketsResults> createState() => _TicketsResultsState();
}

class _TicketsResultsState extends State<TicketsResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Resultats',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.deepPurple[500],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child:  GestureDetector(child: const TicketItem(), onTap: (){
                Navigator.of(context).pushNamed(choosePassengerRoute);
              },),

            ),
          ),
        ],
      ),
    );
  }
}
