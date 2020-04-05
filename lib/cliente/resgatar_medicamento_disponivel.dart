
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:idrug/cliente/requisicao_util.dart';


Future<http.Response> resgatarMedicamentosDisponivel(String cnpj) async {

  http.Response response;
  try {
    response = await http.get(
      getResgatarMedicamentoDisponivel+"?cnpj=$cnpj",
      headers: {"Content-Type": "application/json"},
    ).timeout(Duration(seconds: 15));
  }catch(SocketException){
    return null;
  };

  return (response);
}