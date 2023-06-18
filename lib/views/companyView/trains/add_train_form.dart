import 'package:flutter/material.dart';

typedef ClassCallBack = void Function();

class AddTrain extends StatelessWidget {
  final TextEditingController numero;
  final TextEditingController nbrClasse;
  final ClassCallBack suivant;

  const AddTrain({
    super.key,
    required this.numero,
    required this.nbrClasse,
    required this.suivant,
  });

  @override
  Widget build(BuildContext context) {
    final nombreClasse = int.tryParse(nbrClasse.text);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Train',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 270,
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: numero,
                    enableSuggestions: true, //? important for the email
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
                        Icons.train_outlined,
                      ),
                      hintText: 'Entrer le numéro du train ici',
                      labelText: 'Numéro',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nbrClasse,
                    enableSuggestions: true, //? important for the email
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
                      hintText: 'Entrer le nombre des classes de ce train',
                      labelText: 'Nombre Classe',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OutlinedButton(
                    onPressed: suivant,
                    child: const Text('Suivant'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
