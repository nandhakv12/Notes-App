import 'package:flutter/cupertino.dart';
import 'package:learn/utilities/dialogues/generic_diallog.dart';

Future<bool> showLogoutDialogue(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log Out ',
    content: 'Are you sure you want to log out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then((value) => value ?? false);
}
