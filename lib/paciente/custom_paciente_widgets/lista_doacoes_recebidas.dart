import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/util/itens_lista.dart';



class ListaDoacoesRecebidas extends StatefulWidget {
  var doacoesRecebidas = <DoacoesRecebidas>[];

  ListaDoacoesRecebidas({Key key, @required this.doacoesRecebidas}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListaDoacoesRecebidasState(doacoesRecebidas: doacoesRecebidas);
  }

}

class _ListaDoacoesRecebidasState extends State<ListaDoacoesRecebidas>{
  var doacoesRecebidas = <DoacoesRecebidas>[];

  _ListaDoacoesRecebidasState({@required this.doacoesRecebidas}) ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(

      padding: EdgeInsets.all(10),
      itemCount: doacoesRecebidas.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(

            padding: EdgeInsets.all(15) ,
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doacoesRecebidas[index].nomeMedicamento,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  doacoesRecebidas[index].nomeFarmacia,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  doacoesRecebidas[index].endereco,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  doacoesRecebidas[index].dataDoacao,
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


