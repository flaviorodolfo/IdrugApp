import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idrug/paciente/paciente_logado.screen.dart';
import 'package:idrug/util/validadores.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  UserLoginScreenState createState() {
    return new UserLoginScreenState();
  }
}
final regex = {
  '#': new RegExp(r'[0-9a-zA-Z]')
};
class UserLoginScreenState extends State<UserLoginScreen>{

  var cpfController = new MaskedTextController(mask: '000.000.000-00');
  var senhaController = new MaskedTextController(mask: '################',translator: regex);
  bool cpfControll = true;
  bool senhaControll = true;






  final focusSenha = FocusNode();
  final focusCPF = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.purple,
      body:  GestureDetector(

        behavior: HitTestBehavior.translucent,
        onTap: () {
          String text = cpfController.text;
          cpfControll = validarCPF(text);
          if(text.length == 0)
            cpfControll = true;
          senhaControll = validarSenha(senhaController.text);
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
                    'assets/images/img2.png',
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
                                focusNode: focusCPF,
                                 controller: cpfController,
                                 keyboardType: TextInputType.number,

                                  onSubmitted: (text){
                                   cpfControll  = validarCPF(text);
                                   if(cpfControll)
                                     FocusScope.of(context).requestFocus(focusSenha);
                                   else{
                                     FocusScope.of(context).requestFocus(focusCPF);
                                   }
                                   if(text.length == 0)
                                     cpfControll = true;
                                    setState(() {

                                    });
                                 },

                                 decoration: InputDecoration(
                                   errorText: cpfControll ? null:"CPF inválido",
                                   errorStyle: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                   ),
                                   filled:true,
                                    fillColor: Colors.white,
                                   labelText: 'CPF',
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


                                  obscureText: true,

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
                                  onPressed: (){
                                    String senha, cpf;
                                    senha =  senhaController.text;
                                    cpf = cpfController.text;
                                    senhaControll = validarSenha(senha);
                                    cpfControll = validarCPF(cpf);
                                    if(!cpfControll || !senhaControll)
                                      setState(()=>{});
                                    //else
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => PacienteLogado()),
                                            (Route<dynamic> route) => false);

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
                            Padding(
                              padding: EdgeInsets.only(left: 55,right:55,bottom: 10),
                              child:SizedBox(
                                width: double.infinity,
                                child: FlatButton(

                                  splashColor: Colors.black,
                                  onPressed: (){

                                  },
                                  padding: EdgeInsets.only(top: 12,bottom: 12),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(12.0),
                                  ),
                                  color: Colors.deepPurple,
                                  textColor: Colors.white,
                                  child: Text(
                                    "Cadastrar",
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