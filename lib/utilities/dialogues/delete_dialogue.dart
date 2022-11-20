import 'package:flutter/cupertino.dart';
import 'package:learn/utilities/dialogues/generic_diallog.dart';

Future<bool> showDeleteDialogue(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete ',
    content: 'Are you sure you want to Delete?',
    optionsBuilder: () => {
      'Cancel': false,
      ' Yes': true,
    },
  ).then((value) => value ?? false);
}
