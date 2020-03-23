
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:idrug/cliente//requisicao_util.dart';


Future<http.Response> consultar_Interesses(String cpf) async {

  http.Response response;
  try {
    response = await http.get(
      getConsultarInteressesURL+"?cpf=$cpf",
      headers: {"Content-Type": "application/json"},
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}