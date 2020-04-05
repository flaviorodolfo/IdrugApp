import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';
import 'package:idrug/to/interesse_to.dart';



Future<http.Response> consultarDoacoes(identificador) async {


  http.Response response;
  try {
    response = await http.get(
      getConsultarDoacoesURL+'?identificador='+identificador,
      headers: {"Content-Type": "application/json"},
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}