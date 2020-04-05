import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/to/DoacaoTO.dart';
import 'package:intl/intl.dart';



class ListaDoacoesRealizadas extends StatefulWidget {
   List<DoacaoTO> doacoes;

  ListaDoacoesRealizadas({Key key, @required this.doacoes}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaDoacoesRealizadasState(doacoes: doacoes);
  }

}

class _ListaDoacoesRealizadasState extends State<ListaDoacoesRealizadas>{
  List<DoacaoTO> doacoes;

  _ListaDoacoesRealizadasState({@required this.doacoes}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(

      padding: EdgeInsets.all(10),
      itemCount: doacoes.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(

            padding: EdgeInsets.all(15) ,
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doacoes[index].produto,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  doacoes[index].dosagem,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
//                Text(
//                  doacoesRecebidas[index].endereco,
//                  style: TextStyle(
//                    fontSize: 14.0,
//                    color: Colors.grey,
//                  ),
//                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Coletado no dia "+DateFormat("dd/MM/yyyy").format(DateTime.parse(doacoes[index].data.replaceAll("[UTC]", ""))),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


}


