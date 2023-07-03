import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  late final TextEditingController _depart;
  late final TextEditingController _arrivee;

  @override
  void initState() {
    _depart = TextEditingController();
    _arrivee = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: Colors.purple,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                ),

                // Container(
                //   alignment: Alignment(1, 1),
                //   color: Colors.deepPurple[400],
                //   child: Container(
                //     alignment: Alignment.bottomCenter,
                //     height: 370,
                //     width: 400,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.rectangle,
                //       borderRadius: BorderRadius.circular(20),
                //       color: Colors.deepPurple[600],
                //     ),
                //   ),
                // ),
              ],
            ),
            Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Où désirez-vous voyager ?',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _depart,
                        enableSuggestions: true, //? important for the email
                        autocorrect: false, //? important for the email
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          icon: const Icon(
                            Icons.location_on_sharp,
                            color: Color.fromARGB(255, 74, 44, 156),
                          ),
                          hintText: 'Entrer la ville/station de depart',
                          labelText: 'Depart',
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       child: Divider(
                    //         thickness: 0.8,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     FloatingActionButton(
                    //       onPressed: () {},
                    //       child: const Icon(Icons.swap_vert),
                    //     ),
                    //     const Expanded(
                    //       child: Divider(
                    //         thickness: 0.8,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _arrivee,
                        enableSuggestions: true, //? important for the email
                        autocorrect: false, //? important for the email
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          icon: const Icon(
                            Icons.location_on_sharp,
                            color: Color.fromARGB(255, 74, 44, 156),
                          ),
                          hintText: 'Entrer la ville/station d\'arrivée',
                          labelText: 'Arrivée',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color.fromARGB(255, 113, 68, 239),
                            Color.fromARGB(255, 183, 128, 255),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: OutlinedButton(
                        child: const Text(
                          'Confirmer',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(ticketsResultsRoute);
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
