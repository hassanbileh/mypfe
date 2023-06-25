import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';

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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
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
                trailing:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
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
            style:  TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      
    );
  }
}
