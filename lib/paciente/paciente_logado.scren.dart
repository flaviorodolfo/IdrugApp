import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PacienteLogado extends StatefulWidget {
final String title;



  const PacienteLogado({Key key, this.title}) : super(key: key);

  @override
  _PacienteLogadoState createState() => _PacienteLogadoState();
}
class _PacienteLogadoState extends State<PacienteLogado>{
int _pagSelecionada = 0;
 String _titulo = "Inicial";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
     drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         ListTile(
           selected: true,
           title: Text("IDrug  Usuários",
             style: TextStyle(
               color: Colors.purple,
               fontSize: 22,
             ),
           ),
         ),
          Divider(

            thickness: 1.5,
          ),
          ListTile(

            title: Text('Item 1'),
            onTap: () {
              _onSelectItem(0);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              _onSelectItem(1);
              // Update the state of the app.
              // ...
            },
          ),
        ],
      )

      ),
      body: _getDrawerItem(_pagSelecionada),
    );
  }
  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return Center(child:Text("Tela 1"));
      case 1:
        return Center(child: Text("Tela 2"));
    }
  }

  _onSelectItem(int index) {
    setState(() {
      _pagSelecionada = index;
      _titulo = "NovoTItulo";
    });
    Navigator.of(context).pop();
  }
}

