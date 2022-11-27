import 'package:flutter/cupertino.dart';
import 'package:learn/utilities/dialogues/generic_diallog.dart';

Future<void> showCannotShareEmptyNoteDialogue(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
