import 'package:flutter/material.dart';

class AddTrain extends StatelessWidget {
  final TextEditingController numero;
  const AddTrain({super.key, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train', style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 200,
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
                        borderSide: BorderSide(color: Colors.grey),
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Confirmer'),
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
