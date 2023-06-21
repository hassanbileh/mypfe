import 'package:flutter/material.dart';

typedef TypeSiegeCallBack = void Function();
class ClassForm extends StatelessWidget {
  final TextEditingController nom;
  final TextEditingController description;
  final TextEditingController capacite;
  final TextEditingController nbrTypeSiege;
  final TextEditingController prixClasse;
  final TypeSiegeCallBack? suivant;
  const ClassForm({
    super.key,
    required this.nom,
    required this.description,
    required this.capacite,
    required this.nbrTypeSiege,
    required this.prixClasse, 
    required this.suivant,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Champ Nom
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nom,
                autocorrect: false, //? important for the email
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.class_outlined,
                  ),
                  hintText: 'Entrer le nom de la classe',
                  labelText: 'Nom Classe',
                ),
              ),
            ),
            // Champ Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                controller: description,
                autocorrect: false, 
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.description_outlined,
                  ),
                  hintText: 'Decrivez la classe',
                  labelText: 'Description',
                ),
              ),
            ),
            // Champ Capacité
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: capacite,
                autocorrect: false, //? important for the email
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.my_library_add_outlined,
                  ),
                  hintText: 'Entrer la capacité de la classe',
                  labelText: 'Capacité',
                ),
              ),
            ),
            // Champ Nombre de TypeSiege
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nbrTypeSiege,
                autocorrect: false, //? important for the email
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.content_copy_outlined,
                  ),
                  hintText: 'Entrer le nombre de type siège de la classe',
                  labelText: 'Nombre Type Siège',
                ),
              ),
            ),
            // Champ Prix Classe
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: prixClasse,
                autocorrect: false, //? important for the email
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  icon: const Icon(
                    Icons.price_change_outlined,
                  ),
                  hintText: 'Entrer le prix de la classe',
                  labelText: 'Prix Classe',
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            Visibility(
              visible: (suivant != null) ? true : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: OutlinedButton(
                  onPressed: suivant,
                  child: const Text('Confirmer'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
