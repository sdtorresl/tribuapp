import 'package:flutter/material.dart';

import '../core/color_schemes.dart';

Future<void> showMyDialog(
    BuildContext context, String title, Widget body) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline2
            ?.copyWith(color: Colors.black),
        content: SingleChildScrollView(child: body),
        contentTextStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.black),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Aceptar',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: CustomColors().accent, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
