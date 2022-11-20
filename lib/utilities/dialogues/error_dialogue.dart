import 'package:flutter/cupertino.dart';
import 'package:learn/utilities/dialogues/generic_diallog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error Occured',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
