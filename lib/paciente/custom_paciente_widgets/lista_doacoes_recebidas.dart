import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/to/DoacaoTO.dart';
import 'package:intl/intl.dart';



class ListaDoacoesRecebidas extends StatefulWidget {
   List<DoacaoTO> doacoes;

  ListaDoacoesRecebidas({Key key, @required this.doacoes}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaDoacoesRecebidasState(doacoes: doacoes);
  }

}

class _ListaDoacoesRecebidasState extends State<ListaDoacoesRecebidas>{
  List<DoacaoTO> doacoes;

  _ListaDoacoesRecebidasState({@required this.doacoes}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return doacoes.isEmpty?
    Center(child: Text("Você ainda nao recebeu nenhuma doação.",style: TextStyle(fontSize: 18),),):
    ListView.builder(

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


