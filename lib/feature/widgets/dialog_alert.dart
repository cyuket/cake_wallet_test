import 'package:cake_wallet_test/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(String message,
    {hideButton = false, bool success = false}) {
  return showCupertinoDialog(
    context: navigatorKey.currentState!.context,
    barrierDismissible: true,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          if (!hideButton)
            CupertinoDialogAction(
              onPressed: () {
                navigatorKey.currentState!.pop();
                if (success) {
                  navigatorKey.currentState!.pop();
                }
              },
              child: const Text('Ok'),
            ),
        ],
      );
    },
  );
}
