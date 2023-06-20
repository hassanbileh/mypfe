import 'package:flutter/material.dart';

class AddStation extends StatelessWidget {
  final TextEditingController numero;
  final TextEditingController nom;
  final TextEditingController ville;

  const AddStation({
    super.key,
    required this.numero,
    required this.nom,
    required this.ville,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            //Le numéro de la station
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: numero,
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
                    Icons.numbers_sharp,
                  ),
                  hintText: 'Entrer le numéro ici',
                  labelText: 'Numéro',
                ),
              ),
            ),

            //Nom
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
                  hintText: 'Entrer le nom ici',
                  labelText: 'Nom',
                ),
              ),
            ),

            //Ville
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: ville,
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
                    Icons.location_city_rounded,
                    color: Color.fromARGB(255, 74, 44, 156),
                  ),
                  hintText: 'Entrer la ville ici',
                  labelText: 'Ville',
                ),
              ),
            ),

            
          ],
        ),
    );
  }
}
