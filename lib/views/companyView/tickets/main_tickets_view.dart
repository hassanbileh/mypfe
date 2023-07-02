import 'package:flutter/material.dart';
import 'package:mypfe/views/companyView/tickets/ticket_item.dart';
import 'package:mypfe/widgets/tickets/add_ticket.dart';

class MainTicketView extends StatefulWidget {
  const MainTicketView({super.key});

  @override
  State<MainTicketView> createState() => _MainTicketViewState();
}

class _MainTicketViewState extends State<MainTicketView> {
  void _startAddNewTicket(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: ctx,
      builder: (_) {
        return AddTicket();
      },
    );
  }

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
            _startAddNewTicket(context);
          },
          child: Icon(Icons.add),
        ));
  }
}
