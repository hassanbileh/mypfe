import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/passager.dart';
import 'package:mypfe/models/reservation.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/passager_storage.dart';

class AddPassengers extends StatefulWidget {
  const AddPassengers({
    super.key,
  });

  @override
  State<AddPassengers> createState() => _AddPassengersState();
}

class _AddPassengersState extends State<AddPassengers> {
  String get client => AuthService.firebase().currentUser!.email;
  String? nationalite;
  late final FirebaseCloudPassagerStorage _passengerService;
  late final TextEditingController passeport;
  late final TextEditingController age;
  late final TextEditingController nom;
  late final TextEditingController genre;
  @override
  void initState() {
    _passengerService = FirebaseCloudPassagerStorage();
    nationalite = '';
    passeport = TextEditingController();
    age = TextEditingController();
    nom = TextEditingController();
    genre = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<CloudPassager> _submitDate(BuildContext context) async {
    final queries = context.getArguments<CloudReservation>()!;
    final newPassenger = await _passengerService.createNewPassenger(
      nom: nom.text.trim(),
      nationalite: nationalite!,
      passeport: passeport.text.trim(),
      age: int.tryParse(age.text.trim())!,
      genre: genre.text.trim(),
      client: queries.client,
      ticket: queries.ticketId,
      reservation: queries.documentId,
      classe: queries.classe,
    );
    Navigator.of(context).pop();
    return newPassenger;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un Passager',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[500],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
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
                            hintText: "Entrer le prénom et le nom ici",
                            labelText: "Prénom & Nom",
                          ),
                        ),
                      ),

                      //Nationalité textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Color.fromARGB(255, 74, 44, 156),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CountryListPick(
                              appBar: AppBar(
                                backgroundColor: Colors.deepPurple[500],
                                title: const Text("Selectionner votre pays"),
                              ),
                              theme: CountryTheme(
                                isShowFlag: true,
                                isShowTitle: true,
                                isShowCode: true,
                                isDownIcon: true,
                                showEnglishName: true,
                              ),
                              initialSelection: null,
                              onChanged: (value) {
                                setState(() {
                                  nationalite = value?.name;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      // Nom textField
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passeport,
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
                          onPressed: () async{await _submitDate(context);},
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
