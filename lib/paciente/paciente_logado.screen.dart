import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'package:idrug/util/itens_lista.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class PacienteLogado extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Lista de Desejos", Icons.favorite),
    new DrawerItem("Adicionar Desejo", Icons.add_circle_outline),
    new DrawerItem("Aguardando Coleta", Icons.query_builder),
    new DrawerItem("Doações Recebidas", Icons.receipt)
  ];



  @override
  State<StatefulWidget> createState() {
    return new PacienteLogadoState();
  }
}

class PacienteLogadoState extends State<PacienteLogado> {
  int _selectedDrawerIndex = 0;

 Container cont = Container(
     child: ListView.builder(
       padding: EdgeInsets.all(10.0),
       itemCount: montarDe().length,
       itemBuilder: (BuildContext context, int index) {
         return InkWell(
           onTap: (){

             setState(){
               print(index);
               print(montarDe().length);
               montarDe().removeAt(index);
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
                     montarDe()[index].nomeMedicamento,
                     style: TextStyle(
                       fontSize: 16.0,
                       color: Colors.black,
                     ),
                   ),
                   SizedBox(
                     height: 5.0,
                   ),
                   Text(
                     montarDe()[index].dataPedido,
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


  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return cont;
      case 1:
        return new Text("PÁGINA 2!");
      case 2:
        return new Text("PÁGINA 3!");

      default:
        return new Text("P3+N");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }



  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            new UserAccountsDrawerHeader(
//              decoration: BoxDecoration(
//                color: Colors.purple,
//              ),
//
//                accountName: new Text("nome usuario"), accountEmail:Text("endereço..."),
//
//            ),
            new ListTile(
              title: Text(
                  "IDrug Usuário",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            new Divider(thickness: 1.5),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex)
    );
  }

}