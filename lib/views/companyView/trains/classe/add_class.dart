import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/views/companyView/trains/classe/class_form.dart';

class AddClasse extends StatefulWidget {
  const AddClasse({super.key});

  @override
  State<AddClasse> createState() => _AddClasseState();
}

class _AddClasseState extends State<AddClasse> {
  late final TextEditingController nom;
  late final TextEditingController description;
  late final TextEditingController capacite;
  late final TextEditingController nbrTypeSiege;
  late final TextEditingController prixClasse;

  // List<Widget> displayClassForms(BuildContext context){
  //   final nbrClasse = context.getArguments<int>();
  //   List<Widget> classForms = [];
  //   for (var i = 0; i < nbrClasse!; i++) {
  //     classForms.add(ClassForm(nom: nom, description: description, capacite: capacite, nbrTypeSiege: nbrTypeSiege, prixClasse: prixClasse, suivant: suivant))
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Classes'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}