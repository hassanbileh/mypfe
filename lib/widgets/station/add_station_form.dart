import 'package:flutter/material.dart';
import 'package:mypfe/widgets/components/custom_textfield.dart';

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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Ajouter une station",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //Le numéro de la station
            CustomTextField(
              controller: numero,
              icon: const Icon(
                Icons.numbers_outlined,
                color: Color.fromARGB(255, 74, 44, 156),
              ),
              hintText: 'Le numéro de la station',
              labelText: 'Numéro',
              onSubmitted: null,
              isP: false,
              kbType: TextInputType.visiblePassword,
            ),

            //Nom de la station
            CustomTextField(
              controller: nom,
              icon: const Icon(
                Icons.traffic_rounded,
                color: Color.fromARGB(255, 74, 44, 156),
              ),
              hintText: 'Entrer le nom ici',
              labelText: 'Nom',
              onSubmitted: null,
              isP: false,
              kbType: TextInputType.emailAddress,
            ),

            //Ville de la station
            CustomTextField(
              controller: ville,
              icon: const Icon(
                Icons.location_city_rounded,
                color: Color.fromARGB(255, 74, 44, 156),
              ),
              hintText: 'Entrer la ville ici',
              labelText: 'Ville',
              onSubmitted: null,
              isP: false,
              kbType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
