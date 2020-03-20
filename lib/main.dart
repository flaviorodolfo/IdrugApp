import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:idrug/paciente/tela_usuario_login.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

void main()=>runApp(WelcomeScreen());


FlatButton _getButton(String text){
  return  FlatButton(

    splashColor: Colors.black,
    padding: EdgeInsets.only(top: 12,bottom: 12),
    shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(12.0),
    ),
    disabledColor: Colors.white,
    disabledTextColor: Colors.purple,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 15.0,
      ),
    ),

  );
}
_getPages(BuildContext context){
   return [
    PageViewModel(
      pageColor: Colors.deepPurple,
      title: Text("Lorem Ipsum" ),
      body: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et purus ipsum. In aliquet semper sagittis. Nulla porta, tellus ."),
      mainImage: Image.asset("assets/images/img.png",height: MediaQuery.of(context).size.height*0.5 , width: MediaQuery.of(context).size.height*0.5),
      titleTextStyle: TextStyle( color: Colors.white),
      bodyTextStyle: TextStyle( color: Colors.white),
    ),
    PageViewModel(
      pageColor: Colors.deepPurpleAccent,
      title: Text("Lorem Ipsum"),
      body: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et purus ipsum. In aliquet semper sagittis. Nulla porta, tellus vel ."),
     // mainImage: Image.asset("assets/images/img.png",height: MediaQuery.of(context).size.width*0.2 , width: MediaQuery.of(context).size.width*0.5),
      titleTextStyle: TextStyle( color: Colors.white),
      bodyTextStyle: TextStyle( color: Colors.white),
    ),
    PageViewModel(
      pageColor: Colors.purple,
      title: Text("Lorem Ipsum"),
      body: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et purus ipsum. In aliquet semper sagittis. Nulla porta, tellus vel "),
      mainImage: Image.asset("assets/images/img.png",height: MediaQuery.of(context).size.height*0.2 , width: MediaQuery.of(context).size.height*0.5),
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
          _getPages(context),
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