import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/util/itens_lista.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';



class ListaAguardandoColeta extends StatefulWidget {
  var listaAguardandoColeta = <ListaColeta>[];

  ListaAguardandoColeta({Key key, @required this.listaAguardandoColeta}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaAguardandoColetaState(listaAguardandoColeta: listaAguardandoColeta);
  }

}

class _ListaAguardandoColetaState extends State<ListaAguardandoColeta>{
  var listaAguardandoColeta = <ListaColeta>[];

  _ListaAguardandoColetaState({@required this.listaAguardandoColeta}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(

      padding: EdgeInsets.all(10.0),
      itemCount: listaAguardandoColeta.length,
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
                        listaAguardandoColeta[index].medicamento,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        listaAguardandoColeta[index].nomeFarmacia,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        listaAguardandoColeta[index].endereco,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        listaAguardandoColeta[index].dataLimite,
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

                            title: Text("Realizar Coleta"),


                            backgroundColor: Colors.white,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: <Widget>[
                                SizedBox(


                                  child: QrImage(
                                    data: listaAguardandoColeta[index].codigoColeta,

                                    version: QrVersions.auto,
                                    size: 50,
                                  ),
                                  height: MediaQuery.of(context).size.width*0.5 ,
                                  width: MediaQuery.of(context).size.width*0.5 ,
                                ),
                                Text(
                                    "Para realizar a coleta diriga-se até a farmácia indicada"
                                        " e apresente esse código ao responsável."),
                              ],
                            ),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),

                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  // _launchMapsUrl(-10.9221519, -37.107655);
                                  MapsLauncher.launchQuery(listaAguardandoColeta[index].endereco);
                                  Navigator.pop(context);

                                },
                                padding: EdgeInsets.only(top: 12,bottom: 12),
                                textColor: Colors.green,
                                child: Text(
                                  "Obter localização",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: (){
                                  //TODO CANCELAR COLETA
                                  setState(() {
                                    listaAguardandoColeta.removeAt(index);
                                  });

                                  Navigator.pop(context);
                                },
                                padding: EdgeInsets.only(top: 12,bottom: 12),
                                textColor: Colors.red,
                                child: Text(
                                  "Cancelar coleta",
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
                      Icons.more_horiz),
                )
              ],
            ),
          ),
        );
      },
    );
  }


}