import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';


Future<http.Response> cadastrarPaciente(nome,email,cpf,senha,dataNascimento) async {

  Map data = {
    'nome': nome,
    'senha': senha,
    'cpf': cpf,
    'email': email,
    'dataNascimento': dataNascimento
  };
  
  String body = json.encode(data);
  http.Response response;
  try {
    response = await http.post(
      postCadastrarPacienteURL,
      headers: {"Content-Type": "application/json"},
      body: body,
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}