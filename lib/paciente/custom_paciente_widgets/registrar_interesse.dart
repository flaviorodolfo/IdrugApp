
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:idrug/cliente/cadastrar_interesse.dart';
import 'package:idrug/cliente/requisicao_util.dart';
import 'package:idrug/cliente/resgatar_medicamento.dart';
import 'package:idrug/to/medicamento_to.dart';
import 'package:idrug/to/paciente_to.dart';

class InteresseAutoCompletar extends StatefulWidget {
  PacienteTO _aux;
  List<MedicamentoTO> medicamentos;
  InteresseAutoCompletar(this._aux,this.medicamentos);
  @override
  _InteresseAutoCompletarState createState() => new _InteresseAutoCompletarState(_aux,this.medicamentos);
}

_getMedicamento(String produto,List<MedicamentoTO> med){
  for(int i = 0;i<med.length;i++){
    if(produto == med[i].produto)
      return med[i];
  }
}

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
                      Text("Cadastrando Interesse...",
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


class _InteresseAutoCompletarState extends State<InteresseAutoCompletar> {

  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  PacienteTO _pacienteTO;
  SimpleAutoCompleteTextField textField;
  List<MedicamentoTO> medicamentos  ;
  List<String> sugestoes =[] ;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _InteresseAutoCompletarState(this._pacienteTO,this.medicamentos);

  List<String> _medToSugs(){
    medicamentos.forEach((f)=>(sugestoes.add(f.produto)));
  }

  @override
  void initState() {
    _medToSugs();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
        body:  GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },

          child: SizedBox(
//            color: Colors.yellowAccent,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SimpleAutoCompleteTextField(
                    key: key,
                    decoration: new InputDecoration(
                        hintText: "Medicamento de interesse.",
                        suffixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: Colors.black54,
                              width: 1.7
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                           color: Colors.blue,
                            width: 1.7
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    controller: TextEditingController(),
                    suggestions: sugestoes,
                    textChanged: (text){
                      currentText = text;
                    },
                    clearOnSubmit: true,
                    textSubmitted: (text) => setState(() {
                      showDialog(context: context,
                          builder: (context)=>
                              AlertDialog(
                                title: Text("Adicionar Medicamento"),
                                backgroundColor: Colors.white,
                                content: Text(
                                    "Deseja adicionar o medicamento $text na sua lista de interesses?"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () async {
                                    Navigator.pop(context);
                                      showProcessingDialog(_scaffoldKey.currentState.context);
                                      MedicamentoTO aux = _getMedicamento(text, medicamentos);
                                      Response r = await RegistrarInteresse(_pacienteTO.cpf, aux.produto, aux.dosagem, DateTime.now().toIso8601String());
                                      Navigator.pop(_scaffoldKey.currentState.context);
                                      if(r.statusCode == 200 || r.statusCode == 204){
                                        print(r.statusCode);
                                        _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(content: Text("Interesse cadastrado com sucesso!"),
                                          backgroundColor: Colors.green,
                                          ),
                                        );
                                      }else{
                                        print(r.statusCode);
                                        _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(content: Text("Interesse não cadastrado, esse medicamento "
                                              "já faz parte da sua lista de interesses."),
                                            backgroundColor: Colors.red,
                                          ),
                                        );

                                      }

                                    },
                                    padding: EdgeInsets.only(top: 12,bottom: 12),
                                    textColor: Colors.green,
                                    child: Text(
                                      "Adicionar",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: (){
                                      //TODO CANCELAR COLETA
                                      Navigator.pop(context);
                                    },
                                    padding: EdgeInsets.only(top: 12,bottom: 12),
                                    textColor: Colors.red,
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          );

                    }),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}