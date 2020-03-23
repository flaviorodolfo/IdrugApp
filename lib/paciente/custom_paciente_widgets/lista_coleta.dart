import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/to/coleta_to.dart';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';



class ListaAguardandoColeta extends StatefulWidget {
  List<ColetaTO> coletas ;

  ListaAguardandoColeta({Key key, @required this.coletas}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaAguardandoColetaState(coletas: coletas);
  }

}

class _ListaAguardandoColetaState extends State<ListaAguardandoColeta>{
  List<ColetaTO> coletas;

  _ListaAguardandoColetaState({@required this.coletas}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(

      padding: EdgeInsets.all(10.0),
      itemCount: coletas.length,
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
                        coletas[index].produto,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        coletas[index].farmaciaTO.nome,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
//                      Text(
//                        coletas[index].endereco,
//                        style: TextStyle(
//                          fontSize: 14.0,
//                          color: Colors.grey,
//                        ),
//                      ),
                      SizedBox(
                        height: 5.0,
                      ),
//                      Text(
//                        coletas[index].,
//                        style: TextStyle(
//                          fontSize: 14.0,
//                          color: Colors.grey,
//                        ),
//                      ),
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
                                    data: coletas[index].id.toString(),
                                    version: QrVersions.auto,
                                    size: 50,
                                  ),
                                  height: MediaQuery.of(context).size.width*0.5 ,
                                  width: MediaQuery.of(context).size.width*0.5 ,
                                ),
                                Text(
                                    "Para realizar a coleta dirija-se até a farmácia indicada"
                                        " e apresente esse código ao responsável."),
                              ],
                            ),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),

                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
//                                  // _launchMapsUrl(-10.9221519, -37.107655);
//                                  MapsLauncher.launchQuery(listaAguardandoColeta[index].endereco);
//                                  Navigator.pop(context);

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
                                    coletas.removeAt(index);
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