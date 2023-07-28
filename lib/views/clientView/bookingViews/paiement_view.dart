import 'package:flutter/material.dart';
import 'package:mypfe/constants/routes.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/models/classe.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/classe_storage.dart';
import 'package:mypfe/services/cloud/storage/ticket_storage.dart';

import '../../../models/ticket.dart';

class PaiementView extends StatefulWidget {
  const PaiementView({super.key});

  @override
  State<PaiementView> createState() => _PaiementViewState();
}

class _PaiementViewState extends State<PaiementView> {
  late final TextEditingController numCarte;
  late final TextEditingController dateExp;
  late final TextEditingController ccv;
  late final TextEditingController telephone;
  String get client => AuthService.firebase().currentUser!.email;

  @override
  void initState() {
    numCarte = TextEditingController();
    dateExp = TextEditingController();
    ccv = TextEditingController();
    telephone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fromSelection = context.getArguments<List>();
    final reservation = fromSelection![0];
    final nbrPassagers = fromSelection[1];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
        bottom: PreferredSize(
          // ignore: sort_child_properties_last
          preferredSize: const Size.fromHeight(150),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 130,
                color: Colors.deepPurple,
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: FutureBuilder(
                    future: FirebaseCloudTicketStorage()
                        .getTicket(documentId: reservation!.ticketId),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.done:
                        case ConnectionState.waiting:
                          if (snapshot.hasData) {
                            final ticket = snapshot.data as CloudTicket;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    //Date voyage
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ticket.jour,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.8,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),

                                    //Heure voyage
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            ticket.heureDepart,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text("-"),
                                          ),
                                          Text(
                                            ticket.heureArrive,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Station de depart
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 12),
                                      child: Text(
                                        ticket.depart,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.8,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      child: Text(
                                        ticket.destination,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.person),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            nbrPassagers.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Colors.deepPurple[500]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        ticket.trainNum,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: Colors.deepPurple[500]),
                                      ),
                                    ),
                                    FutureBuilder(
                                      future: FirebaseCloudClasseStorage()
                                          .getClasse(
                                              documentId: reservation.classe),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.done:
                                          case ConnectionState.active:
                                          case ConnectionState.waiting:
                                            if (snapshot.hasData) {
                                              final theClasse =
                                                  snapshot.data as CloudClasse;
                                              return Row(
                                                children: [
                                                  Text(
                                                    theClasse.nom,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18,
                                                        color: Colors
                                                            .deepPurple[500]),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Icon(Icons
                                                            .monetization_on_outlined),
                                                        Text(
                                                          theClasse.prixClasse
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16,
                                                              color: Colors
                                                                      .deepPurple[
                                                                  500]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          default:
                                            return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }

                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        title: const Text(
          'Paiement',
          style: TextStyle(
            color: Colors.white,
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
                      controller: TextEditingController.fromValue(
                          TextEditingValue(text: client)),
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
                      controller: telephone,
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
            Container(
              height: 100,
            )
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
            Navigator.of(context)
                .pushNamedAndRemoveUntil(mainClientRoute, (route) => false);
          },
          child: const Text(
            "Payer la reservation",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
