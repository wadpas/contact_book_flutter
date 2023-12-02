import 'package:flutter/material.dart';

Future<dynamic> errorDialog(context, error) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Error!'),
        content: Text(
          error.message.toString(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          )
        ],
      );
    },
  );
}
