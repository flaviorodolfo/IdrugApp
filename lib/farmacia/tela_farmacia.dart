import 'dart:convert';

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart';
import 'package:idrug/paciente/tela_criar_conta.dart';
import 'package:idrug/paciente/tela_usuario_logado.dart';
import 'package:idrug/cliente/validar_usuario.dart';
import 'package:idrug/to/paciente_to.dart';
import 'package:idrug/util/validadores.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FarmaciaTela extends StatefulWidget {
  @override
  _FarmaciaTelaState createState() {
    return new _FarmaciaTelaState();
  }
}
final regex = {
  '#': new RegExp(r'[0-9a-zA-Z]')
};


_getLoading(){
  return Center(
    child: CircularProgressIndicator(
      //backgroundColor: Colors.white,
    ),
  );
}


class _FarmaciaTelaState extends State<FarmaciaTela>{

  var cnpjController = new MaskedTextController(mask: '000.000.000/000-00');
  var senhaController = new MaskedTextController(mask: '################',translator: regex);
  bool cnpjControll = true;
  bool senhaControll = true;
  bool secretText = true;
  final focusSenha = FocusNode();
  final focusCNPJ = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false  ;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     
      backgroundColor: Colors.purple,
      body: loading? _getLoading(): GestureDetector(

        behavior: HitTestBehavior.translucent,
        onTap: () {
          String text = cnpjController.text;
          cnpjControll = CNPJValidator.isValid(text);
            cnpjControll = text.length == 0;
          senhaControll = validarSenha(senhaController.text);
          senhaControll = senhaController.text.length == 0;
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() => {});

        },

        child: Container(
          child: Column(
                  children: [
                SizedBox(
                  height: 35,
                ),
                Image.asset(
                    'assets/images/img.png',
                    fit: BoxFit.fill,
                    height: 100,
                    color: Colors.blue,

                  ),

                 new Expanded(

                   child: new Center(
                     child: SingleChildScrollView(
                       physics: NeverScrollableScrollPhysics(),
                       child: new Column(
                       //  padding: EdgeInsets.only(top: 10),
                          children: <Widget>[

                             Padding(
                               padding: EdgeInsets.only(top:5,right: 35,left: 35),
                               child: TextField(
                                focusNode: focusCNPJ,
                                 controller: cnpjController,
                                 keyboardType: TextInputType.number,

                                  onSubmitted: (text){
                                   cnpjControll  = CNPJValidator.isValid(text);
                                   if(cnpjControll)
                                     FocusScope.of(context).requestFocus(focusSenha);
                                   else{
                                     FocusScope.of(context).requestFocus(focusCNPJ);
                                   }
                                   if(text.length == 0)
                                     cnpjControll = true;
                                    setState(() {

                                    });
                                 },
                                 decoration: InputDecoration(

                                   prefixIcon: Icon(Icons.person),
                                   errorText: cnpjControll ? null:"CNPJ inválido",
                                   errorStyle: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                   ),

                                   filled:true,
                                    fillColor: Colors.white,
                                   labelText: 'CNPJ',
                                   labelStyle: TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                   ),
                                   hintText: "Apenas números",

                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 35,top: 12,left: 35),
                               child: TextField(

                                 controller: senhaController,
                                 focusNode: focusSenha,
                                 textInputAction: TextInputAction.go,

                                  obscureText: secretText,
                                 onSubmitted: (text){
                                   senhaControll = validarSenha(text);
                                   if(text.length == 0)
                                     senhaControll = true;
                                   if(!senhaControll)
                                     FocusScope.of(context).requestFocus(focusSenha);
                                   setState(() {

                                   });
                                 },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        secretText? Icons.visibility_off:Icons.visibility
                                      ),
                                      onPressed: ()=> setState(() {secretText = !secretText;}),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                   errorText: senhaControll ? null: "A senha deve ter entre 8 e 16 dígitos",
                                   errorStyle: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                   ),
                                   labelText: 'SENHA',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                   hintText: "Apenas letras e dígitos",
                                 ),
                               ),
                             ),
                              Padding(
                                padding: EdgeInsets.only(top:12,left: 50,right:50,bottom: 10),
                              child:SizedBox(
                                width: double.infinity,
                                child: FlatButton(
                                  padding: EdgeInsets.only(top: 12,bottom: 12),
                                   shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(12.0),
                                  ),

                                  splashColor: Colors.black,
                                  onPressed: () async {
                                    String senha, cnpj;
                                    senha =  senhaController.text;
                                    cnpj = cnpjController.text;
                                    senhaControll = validarSenha(senha);
                                    cnpjControll = CNPJValidator.isValid(cnpj);
                                    Response r;
                                    if(!cnpjControll || !senhaControll)
                                      setState(()=>{});
                                    else {
                                      setState(() {
                                        loading = true;
                                      });
                                      r = await validarUsuario(
                                          cnpj.replaceAll("-", "").replaceAll(
                                              ".", ""), senha);
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                    if(r == null)
                                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                                        content: Text("Por favor, verifique sua conexão com a internet."),
                                        backgroundColor: Colors.red,
                                      ));
                                    else {
                                      if (r.statusCode == 200 ||
                                          r.statusCode == 204) {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        PacienteTO aux = PacienteTO.fromJson(jsonDecode(r.body));
                                        prefs.setString('user', jsonEncode(aux.toJson()));
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PacienteLogado(aux)),
                                                (
                                                Route<dynamic> route) => false);
                                      }
                                      if (r.statusCode == 400){
                                        senhaController.text = "";
                                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                                          content: Text("Usuario ou senha inválidos."),
                                          backgroundColor: Colors.red,
                                        ));}

                                    }
                                  },
                                  color: Colors.deepPurple,
                                  textColor: Colors.white,
                                  child: Text(
                                    "Entrar",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ),

                                ),
                              ),
                           ),
                           ],
                         ),
                     ),
                   ),
                 )

              ]),
        ),
      ),


    );
  }
}