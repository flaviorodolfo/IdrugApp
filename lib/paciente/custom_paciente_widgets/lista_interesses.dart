
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/util/itens_lista.dart';

class ListaDesejos extends StatefulWidget {
  var interesses = <Interesse>[];

  ListaDesejos({Key key, @required this.interesses}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaDesejosState(interesses: interesses);
  }

}

class _ListaDesejosState extends State<ListaDesejos>{
  var interesses = <Interesse>[];

  _ListaDesejosState({@required this.interesses}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(

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
                        interesses[index].nomeMedicamento,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        interesses[index].dataPedido,
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
                                "Você está removendo o medicamento "+interesses[index].nomeMedicamento+" da sua lista de interesses."
                                    "\nDeseja continuar?"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  setState(() {
                                    Navigator.pop(context);
                                    //TODO REMover DO BANCO
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
    );
  }


}