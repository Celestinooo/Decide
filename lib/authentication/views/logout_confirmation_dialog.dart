import 'package:flutter/material.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Logout',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Você tem certeza de que deseja fazer logout?',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Não',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: const Text(
            'Sim',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: Colors.grey[400]!,
          width: 1.0,
        ),
      ),
    );
  }
}
