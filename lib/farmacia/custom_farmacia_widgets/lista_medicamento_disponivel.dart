import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:idrug/cliente/cadastrar_medicamento_disponivel.dart';
import 'package:idrug/cliente/resgatar_medicamento_disponivel.dart';
import 'package:idrug/to/coleta_to.dart';
import 'package:idrug/to/medicamento_disponivel_to.dart';
import 'package:idrug/to/medicamento_to.dart';

import 'package:spinner_input/spinner_input.dart';

class ListaMedicamentoDisponivel extends StatefulWidget {
  FarmaciaTO _aux;
  List<MedicamentoTO> medicamentos;
  List<MedicamentoDisponivelTO> medicamentoDisponivel;
  ListaMedicamentoDisponivel(
      this._aux, this.medicamentos, this.medicamentoDisponivel);
  @override
  _ListaMedicamentoDisponivelState createState() =>
      new _ListaMedicamentoDisponivelState(
          _aux, this.medicamentos, medicamentoDisponivel);
}

_getMedicamento(String produto, List<MedicamentoTO> med) {
  for (int i = 0; i < med.length; i++) {
    if (produto == med[i].produto) return med[i];
  }
}

void showProcessingDialog(BuildContext context) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                        SizedBox(
                          height: 15,
                        ),
                        Text("Cadastrando Disponibilidade...",
                            style: TextStyle(
                                fontFamily: "OpenSans", color: Color(0xFF5B6978)))
                      ]
                  )
              )
          );
        },
        );
      }
      );
}

class _ListaMedicamentoDisponivelState
    extends State<ListaMedicamentoDisponivel> {
  double qtMed =  1;
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  FarmaciaTO _farmaciaTO;
  SimpleAutoCompleteTextField textField;
  List<MedicamentoTO> medicamentos;
  List<MedicamentoDisponivelTO> medicamentoDisponivel;
  List<String> sugestoes = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _ListaMedicamentoDisponivelState(
      this._farmaciaTO, this.medicamentos, this.medicamentoDisponivel);
  _hasNoMed(String s) {
    for (int i = 0; i < medicamentoDisponivel.length; i++)
      if (medicamentoDisponivel[i].produto == s) return false;
    return true;
  }
  _novaListaDisp() async {
    Response r = await resgatarMedicamentosDisponivel(_farmaciaTO.cnpj);
    Iterable iterable = jsonDecode(r.body);
    List<MedicamentoDisponivelTO> medicamentosaux =[];
    iterable.forEach((pos)=>(
        medicamentosaux.add(MedicamentoDisponivelTO.fromJson(pos))));
    medicamentoDisponivel = medicamentosaux;
    sugestoes.clear();
    _medToSugs();
  }

  List<String> _medToSugs() {
    for (int i = 0; i < medicamentos.length; i++) {
      if (_hasNoMed(medicamentos[i].produto))
        sugestoes.add(medicamentos[i].produto);
    }
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
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
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
                      hintText: "Cadastrar disponibilidade",
                      suffixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.black54, width: 1.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.blue, width: 1.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    controller: TextEditingController(),
                    suggestions: sugestoes,
                    textChanged: (text) {
                      currentText = text;
                    },
                    clearOnSubmit: true,
                    textSubmitted: (text) => setState(() {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                              builder: (context, setState) {
                            return  AlertDialog(

                            title: Text("Adicionar Disponibilidade"),
                            backgroundColor: Colors.white,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    "Deseja adicionar qual quantia do medicamento $text na sua lista de disponibilidade?"),
                                SizedBox(
                                  width: 5,
                                  height: 5,
                                ),
                                SpinnerInput(
                                  spinnerValue: qtMed,
                                  minValue: 1,
                                  maxValue: 999,
                                  onChange: (newValue) {
                                    setState(() {
                                      qtMed = newValue;
                                    });
                                  },
                                )
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  showProcessingDialog(
                                      _scaffoldKey.currentState.context);
                                  MedicamentoTO aux =
                                      _getMedicamento(text, medicamentos);
                                  Response r =
                                      await cadastrarDisponibilidadeMedicamento(
                                          _farmaciaTO.cnpj,
                                          aux.produto,
                                          aux.dosagem,
                                          "2050-02-22T18:25:43.511Z",
                                          qtMed.toInt());
                                    Navigator.pop(
                                        _scaffoldKey.currentState.context);
                                  if (r.statusCode == 400 ||
                                      r.statusCode == 204) {
                                    _novaListaDisp();
                                    _scaffoldKey.currentState.setState(() {
                                    });
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Disponibilidade cadastrada com sucesso!"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    print(r.statusCode);
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Ocorreu um erro ao cadastrar disponibilidade do medicamento"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                textColor: Colors.green,
                                child: Text(
                                  "Adicionar",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  //TODO CANCELAR COLETA
                                  Navigator.pop(context);
                                },
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                textColor: Colors.red,
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ],
                        );
    }
                          );
                       },
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: medicamentoDisponivel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children:<Widget>[
                              Expanded(
                              child: Column(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    medicamentoDisponivel[index].produto,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    medicamentoDisponivel[index].dosagem,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),GestureDetector(
                                onTap: (){
                                  showDialog(context: context,
                                    builder: (context)=>
                                      StatefulBuilder(
                                      builder: (context, setState) {
                                      return  AlertDialog(
                                        title: Text("Atenção"),
                                          backgroundColor: Colors.white,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                  "Qual a nova quantidade do medicamento selecionado?"),
                                              SizedBox(
                                                width: 5,
                                                height: 5,
                                              ),
                                              SpinnerInput(
                                                spinnerValue: qtMed,
                                                minValue: 0,
                                                maxValue: 999,
                                                onChange: (newValue) {
                                                  setState(() {
                                                    qtMed = newValue;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () async {
                                                showProcessingDialog(_scaffoldKey.currentState.context);
                                                MedicamentoDisponivelTO aux =  medicamentoDisponivel[index];
                                                Response r = await cadastrarDisponibilidadeMedicamento(
                                                 aux.cnpj, aux.produto,aux.dosagem,
                                                    "2050-02-22T18:25:43.511Z",
                                                    qtMed.toInt()
                                                );
                                                Navigator.pop(_scaffoldKey.currentState.context);
                                                if(r.statusCode == 200 || r.statusCode == 204){
                                                  print(r.statusCode);
                                                  _scaffoldKey.currentState.showSnackBar(
                                                    SnackBar(content: Text("Quantidade atualizada!"),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                }else{
                                                  print(r.statusCode);
                                                  _scaffoldKey.currentState.showSnackBar(
                                                      SnackBar(content: Text("Ocorreu um erro ao atualizar a quantidade."),
                                                        backgroundColor: Colors.red,
                                                      ));
                                                };
                                                setState(() {

                                                  _novaListaDisp();
                                                  Navigator.pop(context);
                                                });

                                              },
                                              padding: EdgeInsets.only(top: 12,bottom: 12),
                                              textColor: Colors.green,
                                              child: Text(
                                                "Sim",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              padding: EdgeInsets.only(top: 12,bottom: 12),
                                              textColor: Colors.red,
                                              child: Text(
                                                "Não",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),

                                            ),

                                          ],
                                        );
                                      },
                                     )         ,

                                  );
                                },
                                child: new Icon(
                                    Icons.edit),
                              )
                          ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
