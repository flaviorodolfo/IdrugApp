
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';



Future<http.Response> RegistrarInteresse(identificador,produto,dosagem,dataInteresse) async {

  Map data = {
    'cpf': identificador,
    'produto': produto,
    'dosagem': dosagem,
    'dataInteresse': dataInteresse,
  };
  String body = json.encode(data);
  http.Response response;
  try {
    response = await  http.post(
      postRegistrarInteresseURL,
      headers: {"Content-Type": "application/json"},
      body: body,
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };
  print(response.statusCode);
  return (response);
}