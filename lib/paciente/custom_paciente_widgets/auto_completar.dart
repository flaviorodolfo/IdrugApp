import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InteresseAutoCompletar extends StatefulWidget {
  @override
  _InteresseAutoCompletarState createState() => new _InteresseAutoCompletarState();
}

List<String> _avocado(){
  List<String> sug = [];
  for(int i = 0;i<230;i++){
    sug.add("Avocado $i");
  }
  return sug;
}

class _InteresseAutoCompletarState extends State<InteresseAutoCompletar> {
  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  List<String> suggestions = _avocado();

  SimpleAutoCompleteTextField textField;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        body: GestureDetector(
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
                    suggestions: suggestions,
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
                                    onPressed: (){
                                      // _launchMapsUrl(-10.9221519, -37.107655);
                                    //TODO ADICIONAR MEDICAMENTO
                                      Navigator.pop(context);

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
                      if (text != "") {
                        added.add(text);
                      }
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