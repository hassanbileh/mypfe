import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 250, 250, 250),
              Color.fromARGB(255, 186, 145, 240),
            ],
            begin: Alignment(0, -1),
            end: Alignment(5, 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Company name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Djibouti National Train',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple[400]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Column(
                    children: [
                      Text(
                        'D101',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Departure/Arrival Stations
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        'Nagad',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'djibouti ville',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Dire',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'dire dawa',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Departure Time
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '08:00',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    '20:00',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(choosePassengerRoute);
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 22, 231, 130).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Center(child: Text("Vip")),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(choosePassengerRoute);
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 22, 231, 130).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Center(child: Text("Business")),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(choosePassengerRoute);
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 22, 231, 130).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Center(child: Text("Economie")),
                    ),
                  ),
                ],
              ),
            ),
             
          ],
        ),
      ),
    );
  }
}
