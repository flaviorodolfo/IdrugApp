import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:idrug/util/validadores.dart';



class CriarContaTela extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CriarContaTelaState();
  }
}


final regex = {
  '#': new RegExp(r'[0-9a-zA-Z]'),
};

class _CriarContaTelaState extends State<CriarContaTela> {
  var nomeController = new TextEditingController();
  var cpfController = new MaskedTextController(mask: '000.000.000-00');
  var dateController = new MaskedTextController(mask: '00/00/0000');
  var senhaController = new MaskedTextController(mask: '################',translator: regex);
  var confirmsenhaController = new MaskedTextController(mask: '################',translator: regex);
  var emailController = new TextEditingController();
  var confirmemailController = new TextEditingController();
  bool nomeControl = true;
  bool cpfControl = true;
  bool senhaControl = true;
  bool dataControl = true;
  bool confirmSenhaControl = true;
  bool  emailControl = true;
  bool  confirmEmailcontrol = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Cadastrar"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                  "Informe os Dados:",
                style: TextStyle(fontSize: 25),

              ),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: nomeController,
              onSubmitted: (text){
                bool aux = validarNome(text);
                if(text.isEmpty)
                  aux = true;
                setState(() {
                    nomeControl = aux;
                });

              },

              decoration: InputDecoration(
                errorText: nomeControl ? null: "Nome inválido",
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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: cpfController,
              keyboardType: TextInputType.number,
              onSubmitted: (text){
                bool aux = validarCPF(text);
                if(text.isEmpty)
                  aux = true;
                setState(() {
                  cpfControl = aux;
                });

              },
              decoration: InputDecoration(
                errorText: cpfControl ?null:"CPF inválido",
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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),SizedBox(height: 5,),
            TextField(
              controller: dateController,
              keyboardType: TextInputType.number,
                readOnly: true,
                decoration: InputDecoration(
                labelText: "Data de Nascimento",
                alignLabelWithHint: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                    dateFormat:"dd-MM-yyyy",

                     initialDateTime: DateTime.now(),
                     locale: DateTimePickerLocale.pt_br,
                      maxDateTime: DateTime.now(),
                      onConfirm: (date,inte){
                        print(date);
                        print(int);
                        setState(() {
                          dateController.text = date.toString().substring(8,10)+date.toString().substring(5,7)+date.toString().substring(0,5);
                        });
                      }



                    );

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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),SizedBox(height: 5,),
            TextField(
              onSubmitted: (text){
                bool aux = emailControl = validarEmail(text);
                if(text.isEmpty)
                  aux = true;
                setState(() {
                  emailControl = aux;
                });
              },
              controller: emailController,
              decoration: InputDecoration(
                errorText: emailControl ? null:"Email inválido",
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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),SizedBox(height: 5,),
            TextField(
              onSubmitted: (text){
                setState(() {
                  confirmEmailcontrol = text == emailController.text;
                });
              },
              decoration: InputDecoration(
                labelText: "Confirmar email",
                errorText: confirmEmailcontrol? null: "Emails não coincidem",
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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),SizedBox(height: 5,),
            TextField(
              onSubmitted: (text){
                bool aux = validarSenha(text);
                if(text.isEmpty)
                  aux = true;
                setState(() {
                  senhaControl = aux;
                });
              },
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                errorText: senhaControl? null: "Senha inválida",
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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),SizedBox(height: 5,),
            TextField(
              controller: confirmsenhaController,
              obscureText: true,
              onSubmitted: (text){
                setState(() {
                  confirmSenhaControl = text == senhaController.text;
                });
              },
              decoration: InputDecoration(
                errorText: confirmSenhaControl? null:"Senhas nao coincidem",
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
                enabledBorder:  OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black54, width: 1.7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
