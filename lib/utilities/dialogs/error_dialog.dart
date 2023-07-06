import 'package:flutter/material.dart';
import 'package:mypfe/utilities/dialogs/generic_dialog.dart';

//! Error message for login/register page
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'Une erreur est survenue',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}


