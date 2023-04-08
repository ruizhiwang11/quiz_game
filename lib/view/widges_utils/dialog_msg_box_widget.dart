import 'package:flutter/material.dart';

class DialogMsgBox extends StatefulWidget {
  final String _title;
  final String _msg;
  const DialogMsgBox(String title, String msg)
      : _title = title,
        _msg = msg;

  @override
  _DialogMsgBoxState createState() => _DialogMsgBoxState();
}

class _DialogMsgBoxState extends State<DialogMsgBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget._title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(widget._msg),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    ;
  }
}
