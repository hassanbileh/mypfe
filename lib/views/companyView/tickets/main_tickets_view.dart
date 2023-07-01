import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/views/companyView/tickets/ticket_item.dart';

class MainTicketView extends StatefulWidget {
  const MainTicketView({super.key});

  @override
  State<MainTicketView> createState() => _MainTicketViewState();
}

class _MainTicketViewState extends State<MainTicketView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
        appBar: null,
        body: const SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Padding(
                padding: EdgeInsets.all(10),
                child: TicketItem(),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(createOrUpdateTicketRoute);
          },
          child: Icon(Icons.add),
        ));
  }
}
