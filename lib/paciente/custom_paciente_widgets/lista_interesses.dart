
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:idrug/cliente/remover_interesse.dart';
import 'package:idrug/cliente/requisicao_util.dart';
import 'package:idrug/to/interesse_to.dart';
import 'package:intl/intl.dart';

class ListaInteresses extends StatefulWidget {
  var interesses = <InteresseTO>[];

  ListaInteresses({Key key, @required this.interesses}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaInteressesState(interesses: interesses);
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
                      Text("Removendo Interesse...",
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
class _ListaInteressesState extends State<ListaInteresses>{
  List<InteresseTO> interesses;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _ListaInteressesState({@required this.interesses}) ;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: interesses.isEmpty?
          Center(child: Text("Você ainda nao cadastrou nenhum interesse.",style: TextStyle(fontSize: 18),),):
      ListView.builder(

        padding: EdgeInsets.all(10.0),
        itemCount: interesses.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          interesses[index].produto,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Aguardando desde "+DateFormat("dd/MM/yyyy").format(DateTime.parse(interesses[index].dataInteresse.replaceAll("[UTC]", ""))),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      showDialog(context: context,
                        builder: (context)=>
                            AlertDialog(
                              title: Text("Atenção"),
                              backgroundColor: Colors.white,
                              content: Text(
                                  "Você está removendo o medicamento "+interesses[index].produto+" da sua lista de interesses."
                                      "\nDeseja continuar?"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () async {
                                      showProcessingDialog(_scaffoldKey.currentState.context);
                                                  Response r = await removerInteresse(interesses[index]);
                                      Navigator.pop(_scaffoldKey.currentState.context);
                                      if(r.statusCode == 200 || r.statusCode == 204){
                                      print(r.statusCode);
                                      _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(content: Text("Interesse removido com sucesso!"),
                                          backgroundColor: Colors.green,
                                            ),
                                      );
                                      }else{
                                      print(r.statusCode);
                                      _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(content: Text("Interesse nao removido."),
                                      backgroundColor: Colors.red,
                                      ));
                                      };
                                    setState(() {
                                      Navigator.pop(context);
                                      interesses.removeAt(index);

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
                            ),

                      );
                    },
                    child: new Icon(
                        Icons.close),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}