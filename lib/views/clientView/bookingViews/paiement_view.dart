import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';

class PaiementView extends StatefulWidget {
  const PaiementView({super.key});

  @override
  State<PaiementView> createState() => _PaiementViewState();
}

class _PaiementViewState extends State<PaiementView> {
  late final TextEditingController numCarte;
  late final TextEditingController dateExp;
  late final TextEditingController ccv;

  @override
  void initState() {
    numCarte = TextEditingController();
    dateExp = TextEditingController();
    ccv = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Paiement',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'OpenSans',
          ),
        ),
        backgroundColor: Colors.deepPurple[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 20,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Ajouter une carte",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                  color: Colors.grey[700],
                ),
              ),
            ),
            //Ajouter une carte
            Container(
              margin: const EdgeInsets.all(15),
              height: 250,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: numCarte,
                      enableSuggestions: true, //? important for the email
                      autocorrect: false, //? important for the email
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.none),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Entrer le numéro de carte ici",
                          labelText: "Numéro Carte"),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                            controller: numCarte,
                            enableSuggestions: true, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.none),
                                ),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "MM/YY",
                                labelText: "MM/YY"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 170,
                          child: TextField(
                            controller: numCarte,
                            enableSuggestions: true, //? important for the email
                            autocorrect: false, //? important for the email
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.none),
                                ),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "CVV",
                                labelText: "CVV"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25.0),
                    height: 50,
                    width: 200,
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
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Verifier contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                  color: Colors.grey[700],
                ),
              ),
            ),

            //Verifier Contact
            Container(
              margin: const EdgeInsets.all(15),
              height: 170,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: numCarte,
                      enableSuggestions: true, //? important for the email
                      autocorrect: false, //? important for the email
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.none),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          labelText: "Email"),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: numCarte,
                      enableSuggestions: true, //? important for the email
                      autocorrect: false, //? important for the email
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.none),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          labelText: "Telephone"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 60,
        width: 350,
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
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(mainClientRoute, (route) => false);
          },
          child: const Text(
            "Payer la reservation",
            style:  TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),

    );
  }
}
