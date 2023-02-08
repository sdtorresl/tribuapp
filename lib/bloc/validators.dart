import 'dart:async';

class Validators {
  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError(
          'Correo incorrecto',
        );
      }
    },
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 5) {
        sink.add(password);
      } else {
        sink.addError(
          'El codigo debe ser de mínimo 5 caracteres',
        );
      }
    },
  );
}
