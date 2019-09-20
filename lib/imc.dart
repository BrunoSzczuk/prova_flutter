import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prova_flutter/alert.dart';

class IMC extends StatefulWidget {
  @override
  IMCState createState() => new IMCState();
}

class IMCState extends State<IMC> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool validate = false;
  final altura = new TextEditingController();
  final peso = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calcular IMC"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(15),
          child: new Form(
            key: _key,
            autovalidate: validate,
            child: buildScreen(context),
          ),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Altura'),
          maxLength: 6,
          keyboardType: TextInputType.number,
          validator: validateField,
          controller: altura,
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Peso'),
          keyboardType: TextInputType.number,
          maxLength: 10,
          validator: validateField,
          controller: peso,
        ),
        new RaisedButton(
          onPressed: () {
            calcular(context);
          },
          child: Text('Calcular'),
        ),
        new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Voltar'),
        )
      ],
    );
  }

  String validateField(String value) {
    if (value.length == 0) {
      return "Informe campo!";
    } else if (double.parse(value.replaceAll(",", ".")) <= 0) {
      return 'O valor tem que ser maior que 0';
    }
    return null;
  }

  String getClassificacaoIMC(double resultado) {
    if (resultado < 16) {
      return 'Magreza grau III';
    } else if (resultado >= 16 && resultado < 17) {
      return 'Magreza grau II';
    } else if (resultado >= 17 && resultado < 18.4) {
      return 'Magreza grau I';
    } else if (resultado >= 18.5 && resultado < 25) {
      return 'Adequado';
    } else if (resultado >= 25 && resultado < 30) {
      return 'Pré-Obeso';
    } else if (resultado >= 30 && resultado < 35) {
      return 'Obesidade grau I';
    } else if (resultado >= 35 && resultado < 40) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }

  void calcular(BuildContext context) {
    if (_key.currentState.validate()) {
      double indice = double.parse(peso.text.replaceAll(",", ".")) /
          pow(double.parse(altura.text.replaceAll(",", ".")), 2);

      new Alert().showAlertDialog(
          context,
          "Resultado IMC " +
              indice.toStringAsPrecision(4) +
              " Status: " +
              getClassificacaoIMC(indice));
    }
  }
}
