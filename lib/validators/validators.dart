import 'dart:async';

class Validators {
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.length > 4) {
      sink.add(username);
    } else {
      sink.addError("Ingrese su usuario");
    }
  });

  final simpleValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length > 2) {
      sink.add(data);
    } else {
      sink.addError("Ingrese correctamente la información");
    }
  });
  final simplePhoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length > 8) {
      sink.add(data);
    } else {
      sink.addError("Ingrese correctamente la información");
    }
  });

  final simpleDocumentValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.length > 9) {
      sink.add(data);
    } else {
      sink.addError("Ingrese correctamente la información");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.addError('Por favor, ingrese su clave');
    }
  });

  final validatePayment = StreamTransformer<String, String>.fromHandlers(
      handleData: (payment, sink) {
    if (payment.isEmpty) {
      sink.addError('Por favor, ingrese una cantidad.');
    } else {
      final regex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
      final match = regex.firstMatch(payment);
      if (match == null || match.group(0) != payment) {
        sink.addError(
            'Por favor, verifique los datos ingresados e intente nuevamente');
      } else {
        sink.add(payment);
      }
    }
  });

  final validatePaymentFields =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError('Ingrese todos los datos solicitados');
    } else {
      sink.add(value);
    }
  });

  final validatePropertyFields =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError('Ingrese todos los datos solicitados');
    } else {
      sink.add(value);
    }
  });
  final validateLeaseFields =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError('Ingrese todos los datos solicitados');
    } else {
      sink.add(value);
    }
  });
}
