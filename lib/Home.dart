import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "Resultado";
  TextEditingController _controllerCep = TextEditingController();

  //async pois pode variar o tempo para o servidor responder.
  _recuperarCep() async {

    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json";

    http.Response response;
    //await pois deve esperar a resposta do servidor.
    //sempre usar "Uri.parse(e a strig)"
    response = await http.get(Uri.parse(url));
    //converteu a resposta em um json, com isso armazenou em um MAP
    Map<String, dynamic>  retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "\n${logradouro}, ${complemento}, ${bairro}, ${localidade}";
    });

    print(
      "\nResposta logradouro: ${logradouro}\n"
      "Resposta complemento: ${complemento}\n"
      "Resposta bairro: ${bairro}\n"
      "Resposta localidade: ${localidade}\n"

    );


    //print("resposta: " + response.statusCode.toString());
    //print("resposta: " + response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço WEB"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex: 79005110"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            ElevatedButton(
                onPressed: _recuperarCep,
                child: Text("Clique aqui!")
            ),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
