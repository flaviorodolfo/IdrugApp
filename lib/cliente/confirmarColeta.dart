import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';


Future<http.Response> ConfirmarColeta(idColeta,situacao) async {

  Map data = {
    'idColeta': idColeta,
    'situacao': situacao,

  };

  String body = json.encode(data);
  http.Response response;
  try {
    response = await http.post(
      postConfirmarColeta,
      headers: {"Content-Type": "application/json"},
      body: body,
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}