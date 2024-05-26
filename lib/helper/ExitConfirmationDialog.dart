import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exit Application?'),
      content: const Text('Are you sure you want to exit the application?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Dismiss the dialog and don't exit
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Dismiss the dialog and exit
          },
          child: const Text('Exit'),
        ),
      ],
    );
  }
}
