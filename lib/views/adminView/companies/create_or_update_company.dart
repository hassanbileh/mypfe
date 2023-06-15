// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mypfe/constants/text_field.dart';
import 'package:mypfe/extensions/generics/get_arguments.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/models/users.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/widgets/register_user_form.dart';

import '../../../services/auth/auth_exceptions.dart';

class CreateOrUpdateCompany extends StatefulWidget {
  const CreateOrUpdateCompany({super.key});

  @override
  State<CreateOrUpdateCompany> createState() => _CreateOrUpdateCompanyState();
}

class _CreateOrUpdateCompanyState extends State<CreateOrUpdateCompany> {
  CloudUser? _company;
  late final FirebaseCloudUserStorage _firebaseCloudStorage;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _nom;
  late final TextEditingController _telephone;

  @override
  void initState() {
    _firebaseCloudStorage = FirebaseCloudUserStorage();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _nom = TextEditingController();
    _telephone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _nom.dispose();
    _telephone.dispose();
    super.dispose();
  }

  _submitData() async {
    try {
      final email = _email.text.trim();
      final password = _password.text.trim();
      final confirmPassword = _confirmPassword.text.trim();
      final nom = _nom.text.trim();
      final telephone = int.parse(_telephone.text.trim());
      if (email.isEmpty ||
          password.isEmpty ||
          nom.isEmpty ||
          _telephone.text.isEmpty ||
          confirmPassword.isEmpty) {
        return showErrorDialog(
            context, 'Make sure you filled all requirements');
      }
      await AuthService.firebase().createCompany(
        email: email,
        nom: nom,
        password: password,
        telephone: telephone,
      );
      await AuthService.firebase().sendEmailVerification();
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(
        context,
        'Email dèjà utilisé',
      );
    } on InvalidEmailAuthException {
      await showErrorDialog(
        context,
        'Email invalid',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Make sure all fields are provided',
      );
    } on UserNotLoggedInAuthException {
      await showErrorDialog(
        context,
        'failed to resgister',
      );
    }
  }

  // Future<CloudUser> createOrUpdateCompany(BuildContext context) async{
  //   //Getting arguments passed in navigator route
  //   final widgetCompany = context.getArguments<CloudUser>();
  //   if (widgetCompany != null) {
  //     _company = widgetCompany;
  //     _email.text = widgetCompany.email;
  //     _nom.text = widgetCompany.nom!;
  //     _telephone.text = widgetCompany.telephone.toString();

  //     return widgetCompany;
  //   }

  //   final existingCompany = _company;
  //   if (existingCompany != null) {
  //     return existingCompany;
  //   } else {
  //     _submitData();

  //     // await AuthService.firebase().createClient(
  //     //   email: email,
  //     //   nom: nom,
  //     //   password: password,
  //     //   telephone: telephone,
  //     // );
  //     // final newNote = await _firebaseCloudStorage.createNewCompanyInCloud(email: email, nom: nom, telephone: telephone, isEmailVerified: isEmailVerified)
  //     // _company = newNote;
  //     // return newNote;
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(companyAppBarTitle),
      ),
      body: UserForm(
        title: "Ajouter une compagnie",
        icon: Icons.business,
        email: _email,
        nom: _nom,
        telephone: _telephone,
        password: _password,
        confirmPassword: _confirmPassword,
        buttonText: ajoutButtonText,
        confirm: () {},
        littleTitle: null,
        littleButton: null,
        littleButtonText: null,
      ),
    );
  }
}
