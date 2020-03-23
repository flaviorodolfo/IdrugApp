import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:idrug/paciente/tela_usuario_logado.dart';
import 'package:idrug/paciente/tela_usuario_login.dart';
import 'package:idrug/to/paciente_to.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'farmacia/tela_farmacia.dart';

void main()=>runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool loaded = false;
  PacienteTO paciente;

  Future<void> carregarDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('user')!= null) {
      if(prefs.getString('user').contains("cpf"))
        paciente = PacienteTO.fromJson(jsonDecode(prefs.getString('user')));
      loaded = true;
    }
    else{

    }

  }
  _getClassLoader(){
    return
    PacienteLogado(paciente);
  }

  Widget build(BuildContext context) {

    return MaterialApp(
      color: Colors.purple,
      debugShowCheckedModeBanner: false,
      home:  new FutureBuilder(
          future: carregarDados(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  backgroundColor: Colors.purple,
                  body: Center(child: CircularProgressIndicator())
              );
            } else {
              return loaded?
                  _getClassLoader():
                    WelcomeScreen();


            }
          }
          ),
    );
  }
}



 _getButton(String text){
  return  RaisedButton(
 //   padding: EdgeInsets.only(top: 12,bottom: 12),
    highlightColor: Colors.white,
    splashColor: Colors.transparent,
    shape: new RoundedRectangleBorder(
     // side: new BorderSide(color: Colors.red, width: 1.7),
      borderRadius: BorderRadius.circular(30),

    ),
 //   disabledColor: Colors.purple,
    disabledTextColor: Colors.white,

    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 15.0,
      ),
    ),

  );
}
_getPages(){
   return [
    PageViewModel(
      pageColor: Colors.deepPurple,
      title: Text("Lorem Ipsum",
      style: TextStyle(
        fontSize: 33,
        ),
      ),
      bubbleBackgroundColor: Colors.purple,
      body: Text("Bem Vindo(a) ao iDRUG ",
        style: TextStyle(
          fontSize: 19,
        ),
      ),
//      body: ListView(
//
//          children:<Widget>[
//            Text("Text lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et purus ipsum."
//              " In aliquet semper sagittis. Nulla porta, tellus ."),
//          ],
//      ),
      mainImage: Image.asset("assets/images/img.png",height: 300 , width: 300),
      titleTextStyle: TextStyle( color: Colors.white),


      bodyTextStyle: TextStyle( color: Colors.white),
    ), PageViewModel(
      pageColor: Colors.deepPurpleAccent,
       title: Text("Lorem Ipsum",
         style: TextStyle(
           fontSize: 33,
         ),
       ),
      bubbleBackgroundColor: Colors.white,
      body: Text("O iDRUG é um aplicativo que faz a conexão entre a farmácia que quer doar o medicamento e você, que precisa do mesmo, sem custo nenhum.",
      style: TextStyle(
        fontSize: 20,
        ),
      ),
      mainImage: Image.asset("assets/images/img.png",height: 300 , width: 300),
      titleTextStyle: TextStyle( color: Colors.white),


      bodyTextStyle: TextStyle( color: Colors.white),
    ), PageViewModel(
      pageColor: Colors.purple,
       title: Text("Lorem Ipsum",
         style: TextStyle(
           fontSize: 33,
         ),
       ),
      bubbleBackgroundColor: Colors.deepPurple,
       body: Text("Cadastre o medicamento que tem interesse segundo a receita médica.\n  Lembre-se: a automedicação faz mal a saúde.\nConsulte seu médico ou Farmacêutico para o melhor uso do medicamento .",
         style: TextStyle(
           fontSize: 20,
         ),
       ),
      mainImage: Image.asset("assets/images/img.png",height: 300 , width: 300),
      titleTextStyle: TextStyle( color: Colors.white),


      bodyTextStyle: TextStyle( color: Colors.white),
    ),

  ];
}



class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          _getPages(),
          showNextButton: true,
          showBackButton: true,
          showSkipButton: false,
          backText: _getButton("Voltar"),
          doneText: _getButton("Começar"),
          nextText: _getButton("Avançar"),
      //    skipText: _getButton("Pular"),
          fullTransition: 250,
          pageButtonTextSize: 20,
          onTapDoneButton: (){
                showDialog(context: context,
                builder: (context)=>
                    AlertDialog(
                      title: Text("Como deseja continuar?"),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => UsuarioLoginTela(),
                              ),
                            );
                          },
                          padding: EdgeInsets.only(top: 12,bottom: 12),
                          textColor: Colors.blue,
                          child: Text(
                            "Estou em busca de medicamentos",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => FarmaciaTela(),
                              ),
                            );


                          },
                          padding: EdgeInsets.only(top: 12,bottom: 12),
                          textColor: Colors.blue,
                          child: Text(
                            "Sou responsável por uma farmácia",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15.0,
                            ),
                          ),

                        ),

                      ],
                    ),
                );
          },


        ),
      ),
    );
  }
}