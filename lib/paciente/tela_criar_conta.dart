import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:http/http.dart';
import 'package:idrug/cliente/cadastrar_paciente.dart';


import 'package:idrug/util/validadores.dart';
import 'package:intl/intl.dart';

class CriarContaTela extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CriarContaTelaState();
  }
}
int _StringToInt(String str){
  return int.tryParse(str);
}

bool _validaStringData(String data){
  List<int> days= [];
  List<String> dias = data.split("/");
  dias.forEach((String f)=>(days.add(_StringToInt(f))));
  bool aux = false;
  if (days.length == 3)
    aux  = valida_data(days[0], days[1], days[2]);
  return aux;
}


final regex = {
  '#': new RegExp(r'[0-9a-zA-Z]'),
};


void showProcessingDialog(BuildContext context) async{
  return showDialog(

      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){

        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            content: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 25,
                  ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 15,),
                      Text("Realizando Cadastro...",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              color:  Color(0xFF5B6978)
                          )
                      )
                    ]
                )
            )


        );
      }
  );
}

class _CriarContaTelaState extends State<CriarContaTela> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var nomeController = new TextEditingController();
  var cpfController = new MaskedTextController(mask: '000.000.000-00');
  var dateController = new MaskedTextController(mask: '00/00/0000');
  var senhaController =  new MaskedTextController(mask: '################', translator: regex);
  var confirmsenhaController =  new MaskedTextController(mask: '################', translator: regex);
  var emailController = new TextEditingController();
  var confirmemailController = new TextEditingController();
  bool nomeControl = true;
  bool cpfControl = true;
  bool senhaControl = true;
  bool dataControl = true;
  bool confirmSenhaControl = true;
  bool emailControl = true;
  bool confirmEmailcontrol = true;
  FocusNode focusn1 = new FocusNode();
  FocusNode focusn2 = new FocusNode();
  FocusNode focusn3 = new FocusNode();
  FocusNode focusn4 = new FocusNode();
  FocusNode focusn5 = new FocusNode();
  FocusNode focusn6 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Cadastrar"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
        child: ListView(
          children: <Widget>[
//            Center(
//              child: Text(
//                "Informe os Dados:",
//                style: TextStyle(fontSize: 25),
//              ),
//            ),
            SizedBox(
              height: 3,
            ),
            TextField(
              controller: nomeController,
              onSubmitted: (text) {
                bool aux = validarNome(text);
                if (text.isEmpty) aux = true;
                if(aux)
                  FocusScope.of(context).requestFocus(focusn1);
                setState(() {
                  nomeControl = aux;
                });
              },
              decoration: InputDecoration(
                errorText: nomeControl ? null : "Nome inválido",
                labelText: "Nome Completo",
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.person),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              focusNode: focusn1,
              controller: cpfController,
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                bool aux = validarCPF(text);
                if (text.isEmpty) aux = true;
                if(aux)
                  FocusScope.of(context).requestFocus(focusn2);
                setState(() {
                  cpfControl = aux;
                });
              },
              decoration: InputDecoration(
                errorText: cpfControl ? null : "CPF inválido",
                labelText: "CPF",
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.person),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              focusNode: focusn2,
              controller: dateController,
              onSubmitted: (text) {
               bool aux = _validaStringData(text);
                if(text.length ==0)
                  aux = true;
               if(aux)
                 FocusScope.of(context).requestFocus(focusn3);
                setState(() {
                  dataControl = aux;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: dataControl? null : "Data inválida",
                labelText: "Data de Nascimento",
                alignLabelWithHint: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        dateFormat: "dd-MM-yyyy",
                        initialDateTime: DateTime.now(),
                        locale: DateTimePickerLocale.pt_br,
                        maxDateTime: DateTime.now(), onConfirm: (date, vars) {
                      setState(() {
                        dateController.text = date.toString().substring(8, 10) +
                            date.toString().substring(5, 7) +
                            date.toString().substring(0, 5);
                      });
                    });
                  },
                ),
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.date_range),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              focusNode: focusn3,
              onSubmitted: (text) {
                bool aux = emailControl = validarEmail(text);
                if (text.isEmpty) aux = true;
                if(aux)
                  FocusScope.of(context).requestFocus(focusn4);
                setState(() {
                  emailControl = aux;
                });
              },
              controller: emailController,
              decoration: InputDecoration(
                errorText: emailControl ? null : "Email inválido",
                labelText: "Email",
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.email),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              focusNode: focusn4,
              controller: confirmemailController,
              onSubmitted: (text) {

                if(text == emailController.text)
                    FocusScope.of(context).requestFocus(focusn5);
                setState(() {
                  confirmEmailcontrol = text == emailController.text;
                });
              },
              decoration: InputDecoration(
                labelText: "Confirmar email",
                errorText: confirmEmailcontrol ? null : "Emails não coincidem",
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.email),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              focusNode: focusn5,
              onSubmitted: (text) {
                bool aux = validarSenha(text);
                if (text.isEmpty) aux = true;
                if(aux)
                  FocusScope.of(context).requestFocus(focusn6);
                setState(() {
                  senhaControl = aux;
                });
              },
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                errorText: senhaControl ? null : "Senha inválida",
                labelText: "Senha",
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.lock),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              focusNode: focusn6,
              textInputAction: TextInputAction.go,
              controller: confirmsenhaController,
              obscureText: true,
              onSubmitted: (text) {
                setState(() {
                  confirmSenhaControl = text == senhaController.text;
                });
              },
              decoration: InputDecoration(
                errorText: confirmSenhaControl ? null : "Senhas nao coincidem",
                labelText: "Confirmar Senha",
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(Icons.lock),
                errorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blue, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
             SizedBox(
               height: 5,
             ),
             FlatButton(

              splashColor: Colors.black,
              onPressed: ()  async {
                if(
                validarNome(nomeController.text)
                && validarCPF(cpfController.text)
                && validarEmail(emailController.text)
                && _validaStringData(dateController.text)
                && validarSenha(senhaController.text)
                && senhaController.text == confirmsenhaController.text
                && emailController.text == confirmemailController.text
                ){
                  FocusScope.of(context).requestFocus(new FocusNode());
                    showProcessingDialog(context);
                    Response r =  await cadastrarPaciente(nomeController.text,
                        emailController.text,
                        cpfController.text.replaceAll("-", "").replaceAll(".", ""),
                        senhaController.text,
                        DateFormat("dd/MM/yyyy").parse(dateController.text).toIso8601String());
                      Navigator.pop(context);
                       if(r != null){
                         if(r.statusCode == 204 || r.statusCode == 200) {
                           _scaffoldKey.currentState.showSnackBar(SnackBar(
                             content: Text("Conta criada com sucesso!"),
                             backgroundColor: Colors.green,
                           ));
                           await Future.delayed(Duration(seconds: 3));
                           Navigator.pop(context);
                         }
                          if(r.statusCode == 400 )
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Não foi possível criar a conta. Email ou CPF já estão em uso."),
                          backgroundColor: Colors.red,
                          ));
                           }
                       else{
                         _scaffoldKey.currentState.showSnackBar(SnackBar(
                           content: Text("Por Favor, Verififique sua conexão com a internet."),
                           backgroundColor: Colors.red,
                         ));

                       }






                }else{
                  setState(() {

                    nomeControl = validarNome(nomeController.text);
                    cpfControl = validarCPF(cpfController.text);
                    emailControl = validarEmail(emailController.text);
                     dataControl = _validaStringData(dateController.text);
                     senhaControl = validarSenha(senhaController.text);
                     confirmSenhaControl = senhaController.text == confirmsenhaController.text;
                     confirmEmailcontrol = emailController.text == confirmemailController.text;
                  });
                }

              },
              padding: EdgeInsets.only(top: 12,bottom: 12),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Colors.purple,
              textColor: Colors.white,
              child: Text(
                "Cadastrar",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
