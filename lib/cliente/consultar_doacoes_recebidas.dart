import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';
import 'package:idrug/to/interesse_to.dart';



Future<http.Response> consultarDoacoes(cpf) async {


  http.Response response;
  try {
    response = await http.get(
      getConsultarDoacoesURL+'?cpf='+cpf,
      headers: {"Content-Type": "application/json"},
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}