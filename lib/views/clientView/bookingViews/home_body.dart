import 'package:flutter/material.dart';
import 'package:mypfe/widgets/booking/search_ticket.dart';

typedef ShowCalendar = void Function();
typedef Swap = void Function();
typedef Search = void Function()?;
typedef CallPassengersNum = void Function()?;

class HomeBody extends StatelessWidget {
  final ShowCalendar showCalendar;
  final Swap swap;
  final Search search;
  final CallPassengersNum nbrPassengers;
  final String? selectedDate;
  final TextEditingController selectedFromStation;
  final TextEditingController selectedToStation;
  const HomeBody({
    super.key,
    required this.showCalendar,
    required this.swap,
    this.search,
    this.nbrPassengers,
    this.selectedDate,
    required this.selectedFromStation,
    required this.selectedToStation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Où désirez-vous voyager ?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(
          height: 10.0,
        ),

        SearchTicket(
          selectedFromStation: selectedFromStation,
          selectedToStation: selectedToStation,
          showCalendar: showCalendar,
          swap: swap,
          search: search,
          selectedDate: selectedDate,
          nbrPassengers: nbrPassengers,
        )
      ],
    );
  }
}

