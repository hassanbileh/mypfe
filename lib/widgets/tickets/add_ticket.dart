
import 'package:flutter/material.dart';

import '../text_field_form.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({super.key});

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  late final TextEditingController depart;
  late final TextEditingController destination;
  late final int jour;
  late final int heureDepart;
  late final int heureArrive;
  late final bool status;

  @override
  void initState() {
    depart = TextEditingController();
    destination = TextEditingController();
    jour = DateTime.now().day;
    heureDepart = DateTime.now().hour;
    heureArrive = DateTime.now().hour;
    status = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                const Icon(
                  Icons.confirmation_num_rounded,
                  size: 50,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Station de départ
                      TextFieldForm(
                        textController: depart,
                        iconData: Icons.traffic_sharp,
                        hintText: "Entrer la station de départ ici",
                        labelText: "De",
                        isString: true,
                      ),

                      TextFieldForm(
                        textController: destination,
                        iconData: Icons.traffic_sharp,
                        hintText: "Entrer la station d'arrivée ici",
                        labelText: "À",
                        isString: false,
                      ),

                     

                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: 330,
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
                          onPressed: () {},
                          child: const Text(
                            "Ajouter",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
