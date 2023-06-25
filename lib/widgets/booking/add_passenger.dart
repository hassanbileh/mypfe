import 'package:flutter/material.dart';

class AddPassengers extends StatefulWidget {
  const AddPassengers({
    super.key,
  });

  @override
  State<AddPassengers> createState() => _AddPassengersState();
}

class _AddPassengersState extends State<AddPassengers> {
  late final TextEditingController nationalite;
  late final TextEditingController numPassport;
  late final TextEditingController age;
  late final TextEditingController nom;
  late final TextEditingController genre;
  @override
  void initState() {
    nationalite = TextEditingController();
    numPassport = TextEditingController();
    age = TextEditingController();
    nom = TextEditingController();
    genre = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un Passager',
          style: TextStyle(fontSize: 18),
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
                  Icons.person,
                  size: 50,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Email textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: nom,
                          enableSuggestions: true, //? important for the email
                          autocorrect: false, //? important for the email
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            icon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            hintText: "Entrer le nom ici",
                            labelText: "Nom",
                          ),
                        ),
                      ),

                      // Nom textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: numPassport,
                          enableSuggestions: true, //? important for the email
                          autocorrect: false, //? important for the email
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            icon: const Icon(
                              Icons.person_pin_rounded,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            hintText: "Entrer le numéro de passeport ici",
                            labelText: "Passeport",
                          ),
                        ),
                      ),

                      // Age textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: age,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            icon: const Icon(
                              Icons.timelapse_sharp,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            hintText: "Entrer l'age ici",
                            labelText: "Age",
                          ),
                        ),
                      ),

                      //Genre textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: genre,
                          obscureText: true, // important for the password
                          enableSuggestions:
                              false, // important for the password
                          autocorrect: false, // important for the password
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            icon: const Icon(
                              Icons.male_rounded,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            hintText: "Entrer le genre ici",
                            labelText: "Genre",
                          ),
                        ),
                      ),
                      //Naitonalité textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: nationalite,
                          obscureText: true, // important for the password
                          enableSuggestions:
                              false, // important for the password
                          autocorrect: false, // important for the password
                          onSubmitted: (_) {},
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            icon: const Icon(
                              Icons.question_mark_outlined,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            hintText: "Entrer la nationalité ici",
                            labelText: "Nationalité",
                          ),
                        ),
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
                          child: Text(
                            "Ajouter",
                            style: const TextStyle(
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
