import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';

class ChoosePassenger extends StatefulWidget {
  const ChoosePassenger({super.key});

  @override
  State<ChoosePassenger> createState() => _ChoosePassengerState();
}

class _ChoosePassengerState extends State<ChoosePassenger> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Select Passager',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
          ),
        ),
        backgroundColor: Colors.deepPurple[500],
        // bottom: PreferredSize(
        //     child: Card(
        //       child: Column(
        //         children: [
        //            Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //               Text(
        //                 "Jul 10, 2023",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.w600),
        //               ),
        //               Text(
        //                 "-",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.w600),
        //               ),
        //               Text(
        //                 "08:00 - 20:00",
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.w600),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //     preferredSize: Size(300, 120)),
      
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.deepPurple[500],
                ),
                Container(
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Jul 10, 2023",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "08:00 - 20:00",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Row(
                          children: [
                            Text(
                              "djibouti ville, Nagad",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "dire dawa, Dire",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Djibouti National Train",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple[500],
                              ),
                            ),
                            const Text(
                              "D101",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Add Passenger
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(addPassengerRoute);
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 80,
                  width: 400,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Ajouter un passager",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                              color: Colors.deepPurple[500]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Passagers Recents",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            //Passen item
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: ListTile(
                leading: Checkbox(
                  value: checkValue,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      checkValue = value as bool;
                    });
                  },
                ),
                title: const Text("Hassan Billeh"),
                subtitle: const Row(
                  children: [
                    Text("26 ans"),
                    SizedBox(
                      width: 5,
                    ),
                    Text("|"),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Djibouti")
                  ],
                ),
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 350,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color.fromARGB(255, 113, 68, 239),
              Color.fromARGB(255, 183, 128, 255),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(paiementViewRoute);
          },
          child: const Text(
            "Payer la reservation",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
