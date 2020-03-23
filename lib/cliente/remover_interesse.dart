
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrug/cliente/requisicao_util.dart';
import 'package:idrug/to/interesse_to.dart';



Future<http.Response> removerInteresse(InteresseTO interesse) async {


  http.Response response;
  try {
    int id = interesse.id;
    response = await http.delete(
        postRemoverInteresseURL+'?id=$id',
        headers: {"Content-Type": "application/json"},
    ).timeout(Duration(seconds: 10));
  }catch(SocketException){
    return null;
  };

  return (response);
}