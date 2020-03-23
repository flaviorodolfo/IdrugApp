
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';


import 'package:idrug/cliente/requisicao_util.dart';

Future<Response> validarUsuario(identificador,senha) async {

  Map data = {
    'identificador': identificador,
    'senha': senha,
  };

  String body = json.encode(data);
  http.Response response;
  try {
    response = await http.post(
      postValidarUsuarioURL,
      headers: {"Content-Type": "application/json"},
      body: body,
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}