import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/paciente/custom_paciente_widgets/auto_completar.dart';
import'package:idrug/util/itens_lista.dart';
import 'custom_paciente_widgets/lista_coleta.dart';
import 'custom_paciente_widgets/lista_doacoes_recebidas.dart';
import 'custom_paciente_widgets/lista_interesses.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class PacienteLogado extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Lista de Interesses", Icons.favorite),
    new DrawerItem("Adicionar Interesse", Icons.add_circle_outline),
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
  var desejo = montarDe();



  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return ListaDesejos( interesses: montarDe());
      case 1:
        return new InteresseAutoCompletar();
      case 2:
        return new ListaAguardandoColeta(listaAguardandoColeta: montarColeta());

      default:
        return new ListaDoacoesRecebidas(doacoesRecebidas: montarDoa());
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }



  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    final itemColor = [
      Color.fromRGBO(41, 162, 242,1),
      Color.fromRGBO(255, 68, 0,1),
      Color.fromRGBO(3, 166, 28,1),
      Color.fromRGBO(200, 0, 255,1)
    ];
    final backColor = [
      Color.fromRGBO(151, 240, 226,100),
      Color.fromRGBO(245, 146, 110,100),
      Color.fromRGBO(122, 240, 140,100),
      Color.fromRGBO(210, 120, 235,100)
    ];
    var desejo = montarDe();
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.only(topRight:  Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                color: i == _selectedDrawerIndex? backColor[i]:Colors.transparent,

            ),
         //   color: i == _selectedDrawerIndex? Colors.red:Colors.transparent,
            child: new ListTile(
              leading: new Icon(
                  d.icon,
                color: i == _selectedDrawerIndex? itemColor[i]:Colors.black,
                  ),
              title: new Text(
                  d.title,
                 style: TextStyle(
                   color: i == _selectedDrawerIndex? itemColor[i]:Colors.black,
                 ),
              ),

              selected: i == _selectedDrawerIndex,
              onTap: () => _onSelectItem(i),
            ),
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
    //  body: _getDrawerItemWidget(_selectedDrawerIndex)
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

}
