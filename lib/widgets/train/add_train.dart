import 'package:flutter/material.dart';



class AddTrain extends StatelessWidget {
  final TextEditingController numero;
  final TextEditingController nbrClasse;

  const AddTrain({
    super.key,
    required this.numero,
    required this.nbrClasse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
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
                
                // Container(
                //   width: 150,
                //   decoration: BoxDecoration(
                //     gradient: const LinearGradient(
                //       colors: <Color>[
                //         Color.fromARGB(255, 113, 68, 239),
                //         Color.fromARGB(255, 183, 128, 255),
                //       ],
                //     ),
                //     borderRadius: BorderRadius.circular(15),
                //   ),
                //   child: TextButton(
                //     onPressed: () {
                //       suivant;
                //     },
                //     child: const Text(
                //       'Confirmer',
                //       style: TextStyle(color: Colors.white, fontSize: 16),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
