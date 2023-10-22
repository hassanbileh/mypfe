import 'package:flutter/material.dart';
import 'package:mypfe/widgets/components/gradient_button.dart';

import '../components/custom_textfield.dart';

typedef ShowCalendar = void Function();
typedef Swap = void Function();
typedef Search = void Function()?;
typedef CallPassengersNum = void Function()?;

class SearchTicket extends StatelessWidget {
  const SearchTicket({
    super.key,
    required this.selectedFromStation,
    required this.selectedToStation,
    required this.showCalendar,
    required this.swap,
    required this.search,
    required this.nbrPassengers,
    required this.selectedDate,
  });

  final ShowCalendar showCalendar;
  final Swap swap;
  final Search search;
  final CallPassengersNum nbrPassengers;
  final String? selectedDate;
  final TextEditingController selectedFromStation;
  final TextEditingController selectedToStation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.6, -0.58),
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width * 0.95,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: selectedFromStation,
                icon: null,
                hintText: 'De',
                labelText: null,
                onSubmitted: null,
                isP: false,
                kbType: TextInputType.name,
              ),
              CustomTextField(
                controller: selectedToStation,
                icon: null,
                hintText: 'À',
                labelText: null,
                onSubmitted: null,
                isP: false,
                kbType: TextInputType.name,
              ),
              //date & passengers
              Row(
                children: [
                  GestureDetector(
                    onTap: showCalendar,
                    child: Container(
                      height: 50,
                      width: 170,
                      margin: const EdgeInsets.only(left: 10.0, top: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text((selectedDate == null) ? 'Date' : selectedDate!),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: nbrPassengers,
                    child: Container(
                      height: 50,
                      width: 170,
                      margin: const EdgeInsets.only(left: 10.0, top: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(Icons.person),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('(1) Adulte'),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: GradientButton(
                  buttonText: 'Rechercher',
                  onPressed: search,
                  height: 50,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: swap,
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: Colors.deepPurple[500]),
            child: const Icon(
              Icons.swap_vert,
              color: Colors.white,
            )),
      ],
    );
  }
}
