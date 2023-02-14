import 'package:bmwapp/common/action_button.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ActionButton(
        text: "Prueba",
        onPressed: () => print("Hola"),
      ),
    ));
  }
}
