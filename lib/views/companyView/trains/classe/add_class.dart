import 'package:flutter/material.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/widgets/classe/add_class_form.dart';

class AddClasse extends StatefulWidget {
  const AddClasse({super.key});

  @override
  State<AddClasse> createState() => _AddClasseState();
}

class _AddClasseState extends State<AddClasse> {
  late final TextEditingController _nom;
  late final TextEditingController _description;
  late final TextEditingController _capacite;
  late final TextEditingController _nbrTypeSiege;
  late final TextEditingController _prixClasse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassForm(
              nom: _nom,
              description: _description,
              capacite: _capacite,
              nbrTypeSiege: _nbrTypeSiege,
              prixClasse: _prixClasse,
              suivant: () {},
            ),
          ],
        ),
      ),
    );
  }
}
