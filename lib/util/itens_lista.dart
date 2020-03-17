import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Desejo{
  var nomeMedicamento;
  var dataPedido;
   Desejo(String nome,String data){
    nomeMedicamento = nome;
    dataPedido = data;
  }
}
void _removeFromList(Desejo obj,List<Desejo> lista){
  lista.remove(obj);
}


Container montarListView(List<Desejo> desejo) {
  return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: desejo.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){

              setState(){
                print(index);
                print(desejo.length);
                desejo.removeAt(index);
              }
            },
            child: Card(

              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      desejo[index].nomeMedicamento,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      desejo[index].dataPedido,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
  );
}
Card _montarCardDesejos(Desejo desejo,List<Desejo> lista){
  return Card(


    child: InkWell(
      onTap: (){
        _removeFromList(desejo,lista);
        print("kkk");
        print(lista.length);
        setState(){
        }
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              desejo.nomeMedicamento,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              desejo.dataPedido,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
List<Widget> getCardListaItens (List<Desejo> desejos){
  var lista = <Card>[];
  for(int i =0;i<10;i++)
    lista.add(_montarCardDesejos(desejos[i],desejos));
  return lista;
}
List<Desejo> montarDe(){
  var lista = <Desejo>[];
  for(int i =0;i<10;i++)
    lista.add(new Desejo("Medicamento $i", "Aguardando Desde $i$i/$i$i/$i$i$i$i às $i$i:$i$i:$i$i"));
  return lista;
}