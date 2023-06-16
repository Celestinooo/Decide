import 'package:flutter/material.dart';

class AuthenticationFailedDialog extends StatelessWidget {
  final String title;
  final String content;
  const AuthenticationFailedDialog({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      content:  Text(
        content,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.grey[200],
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Colors.grey[400]!,
            width: 1.0,
          )
      ),

    );
  }
}
