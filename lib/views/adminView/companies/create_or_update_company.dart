// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/models/users.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/utilities/dialogs/error_dialog.dart';
import 'package:mypfe/views/adminView/user_form.dart';

import '../../../services/auth/auth_exceptions.dart';

class CreateOrUpdateCompany extends StatefulWidget {
  const CreateOrUpdateCompany({super.key});

  @override
  State<CreateOrUpdateCompany> createState() => _CreateOrUpdateCompanyState();
}

class _CreateOrUpdateCompanyState extends State<CreateOrUpdateCompany> {
  CloudUser? _company;
  late final FirebaseCloudStorage _firebaseCloudStorage;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _nom;
  late final TextEditingController _telephone;

  @override
  void initState() {
    _firebaseCloudStorage = FirebaseCloudStorage();
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
      final email = _email.text;
      final password = _password.text;
      final confirmPassword = _confirmPassword.text;
      final nom = _nom.text;
      final telephone = int.parse(_telephone.text);
      if (email.isEmpty ||
          password.isEmpty ||
          nom.isEmpty ||
          _telephone.text.isEmpty ||
          confirmPassword.isEmpty) {
        await showErrorDialog(
          context,
          'Please make sure you filled all requirements',
        );
        return null;
      }
      if (password != confirmPassword) {
        await showErrorDialog(
          context,
          'Please make sure that Confirm password & Password are the same',
        );
        return null;
      } else {
        final existingCompany = _company;
        if (existingCompany != null) {
          return existingCompany;
        } else {
          //Create Company
          final user = await AuthService.firebase().createCompany(
            email: email,
            nom: nom,
            password: password,
            telephone: telephone,
          );
          //Send email verification
          await AuthService.firebase().sendEmailVerification();
          final companyEmail = user.email;
          final company =
              await _firebaseCloudStorage.getUser(email: companyEmail);
          _company = company;
          return company;
        }
      }
    } on WeakPasswordAuthException {
      await showErrorDialog(
        context,
        'Weak password',
      );
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(
        context,
        'Email already in use',
      );
    } on InvalidEmailAuthException {
      await showErrorDialog(
        context,
        'Invalid email',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Registration Error',
      );
    } on UserNotLoggedInAuthException {
      await showErrorDialog(
        context,
        'failed to resgister',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return UserForm(
      title: 'Company',
      email: _email,
      nom: _nom,
      telephone: _telephone,
      password: _password,
      confirmPassword: _confirmPassword,
      confirm: () => _submitData(),
    );
  }
}
