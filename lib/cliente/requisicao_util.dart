import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';


@protected
final String _urlServico = 'http://142.11.219.177:8080/idrugWS/idrugWS/api';
@protected
final String postCadastrarPacienteURL = _urlServico+'/usuario/cadastrar-paciente';
@protected
final String postValidarUsuarioURL = _urlServico+"/seguranca/validar";
@protected
final String getResgatarMedicamentoURL = _urlServico+"/medicamento/resgatar";
@protected
final String postRegistrarInteresseURL = _urlServico+"/doacao/interesse/cadastrar";
@protected
final String getConsultarInteressesURL = _urlServico+"/doacao/interesse/resgatar";
@protected
final String postRemoverInteresseURL = _urlServico+"/doacao/interesse/deletar";
@protected
final String getConsultarColetasURL = _urlServico+"/doacao/coleta/resgatar";
@protected
final String getConsultarDoacoesURL = _urlServico+"/doacao/resgatar";
