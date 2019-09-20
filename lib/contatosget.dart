import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DolarComercialGet extends StatefulWidget {
  @override
  _DolarComercialGETState createState() => new _DolarComercialGETState();
}

class _DolarComercialGETState extends State<DolarComercialGet> {
  String url = 'https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/Moedas?%24format=json';
  List data;

  @override
  void initState() {
    super.initState();
    callDolar();
  }

  Future<String> callDolar() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var dados = json.decode(response.body);
      data = dados["value"];
      print(data);
    });
  }

  @override
  Widget build2(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dólar Comercial'),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return new ListTile(
              title: new Text(data[i]["name"]["first"]),
              subtitle: new Text(data[i]["phone"]),
              leading: new CircleAvatar(
                backgroundImage:
                    new NetworkImage(data[i]["picture"]["thumbnail"]),
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dólar Comercial'),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return new ListTile(
              title: new Text(data[i]["nomeFormatado"]),
              subtitle: new Text(data[i]["simbolo"]),
              leading: new Text(data[i]["tipoMoeda"])
              );
        },
      ),
    );
  }
}
