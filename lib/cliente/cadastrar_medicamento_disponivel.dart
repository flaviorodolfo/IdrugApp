import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';


Future<http.Response> cadastrarDisponibilidadeMedicamento(cnpj,produto,dosagem,dataValidade,quantidade) async {

  Map data = {
    'cnpj': cnpj,
    'produto': produto,
    'dosagem': dosagem,
    'dataValidade': dataValidade,
    'quantidade': quantidade
  };

  String body = json.encode(data);
  http.Response response;
  try {
    response = await http.post(
      postCadastrarMedicamentoDisponivel,
      headers: {"Content-Type": "application/json"},
      body: body,
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}