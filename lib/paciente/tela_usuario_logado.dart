import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idrug/cliente/consultar_coleta.dart';
import 'package:idrug/cliente/consultar_doacoes.dart';
import 'package:idrug/cliente/consultar_interesses.dart';

import 'package:idrug/cliente/resgatar_medicamento.dart';
import 'package:idrug/main.dart';
import 'package:idrug/paciente/custom_paciente_widgets/registrar_interesse.dart';
import 'package:idrug/to/DoacaoTO.dart';
import 'package:idrug/to/coleta_to.dart';
import 'package:idrug/to/interesse_to.dart';
import 'package:idrug/to/medicamento_to.dart';
import 'package:idrug/to/paciente_to.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'custom_paciente_widgets/lista_aguardando_coleta.dart';
import 'custom_paciente_widgets/lista_doacoes_recebidas.dart';
import 'custom_paciente_widgets/lista_interesses.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class PacienteLogado extends StatefulWidget {
  PacienteTO _pacienteAux;
  final drawerItems = [
    new DrawerItem("Lista de Interesses", Icons.favorite),
    new DrawerItem("Adicionar Interesse", Icons.add_circle_outline),
    new DrawerItem("Aguardando Coleta", Icons.query_builder),
    new DrawerItem("Doações Recebidas", Icons.receipt)
  ];

  PacienteLogado(@required this._pacienteAux);

  @override
  State<StatefulWidget> createState() {
    return new _PacienteLogadoState(_pacienteAux);
    }
  }

_getLoadingScreen() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

_jsonListToMedicamento(String jsonString){
  Iterable iterable = jsonDecode(jsonString);
  List<MedicamentoTO> medicamentos =[];
  iterable.forEach((pos)=>(
      medicamentos.add(MedicamentoTO.fromJson(pos))));
  return medicamentos;
}
_jsonListToInteresses(String jsonString){
  Iterable iterable = jsonDecode(jsonString);
  List<InteresseTO> interesses =[];
  iterable.forEach((pos)=>(
      interesses.add(InteresseTO.fromJson(pos))));
  return interesses;
}

_jsonListToColetas(String jsonString){
  Iterable iterable = jsonDecode(jsonString);
  List<ColetaTO> coletas =[];
  iterable.forEach((pos)=>(
      coletas.add(ColetaTO.fromJson(pos))));
  return coletas;
}

_jsonListToDoacoes(String jsonString){
  Iterable iterable = jsonDecode(jsonString);
  List<DoacaoTO> doacoes =[];
  iterable.forEach((pos)=>(
      doacoes.add(DoacaoTO.fromJson(pos))));
  return doacoes;
}

class _PacienteLogadoState extends State<PacienteLogado> {
  int _selectedDrawerIndex = 0;
  final PacienteTO paciente;
  InteresseAutoCompletar interesses;
  bool interesseCarregado = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  _PacienteLogadoState( this.paciente);




  _getDrawerItemWidget(int pos)   {
    switch (pos) {
      case 0:
        return  FutureBuilder(
            future: consultar_Interesses(paciente.cpf),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _getLoadingScreen();
              } else {
                if(snapshot.data == null) {
                  return new Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Favor verificar conexão com a rede.",
                          style: TextStyle(
                            fontSize: 18,
                          ),),
                        RaisedButton(
                            padding: EdgeInsets.all(10),
                            color: Colors.purpleAccent,
                            child: Text("Tentar novamente"),
                            onPressed: () {
                              setState(() {});
                            }
                        ),
                      ],
                    ),
                  );
                }else{
                  return ListaInteresses(interesses: _jsonListToInteresses(snapshot.data.body),);
                }
              }
            });
      case 1:
        if(interesseCarregado) {
          return interesses;
        }
          return FutureBuilder(
            future: resgatarMedicamento(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                       return _getLoadingScreen();
              } else {
                if(snapshot.data == null || snapshot.data.statusCode == 400) {
                  return new Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Favor verificar conexão com a rede.",
                          style: TextStyle(
                            fontSize: 18,
                          ),),
                        RaisedButton(
                            padding: EdgeInsets.all(10),
                            color: Colors.purpleAccent,
                            child: Text("Tentar novamente"),
                            onPressed: () {
                              setState(() {});
                            }
                        ),
                      ],
                    ),
                  );
                }else{
                  interesseCarregado = true;
                  interesses = InteresseAutoCompletar(paciente,_jsonListToMedicamento(snapshot.data.body));

                  return interesses;
                }
              }
            });
        break;

      case 2:
        return  FutureBuilder(
            future: consultarColeta(paciente.cpf),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _getLoadingScreen();
              } else {
                if(snapshot.data == null) {
                  return new Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Favor verificar conexão com a rede.",
                          style: TextStyle(
                            fontSize: 18,
                          ),),
                        RaisedButton(
                            padding: EdgeInsets.all(10),
                            color: Colors.purpleAccent,
                            child: Text("Tentar novamente"),
                            onPressed: () {
                              setState(() {});
                            }
                        ),
                      ],
                    ),
                  );
                }else{
                  return ListaAguardandoColeta(coletas: _jsonListToColetas(snapshot.data.body),);
                }
              }
            });

      case 3:
        return  FutureBuilder(
            future: consultarDoacoes(paciente.cpf),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _getLoadingScreen();
              } else {
                if(snapshot.data == null) {
                  return new Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Favor verificar conexão com a rede.",
                          style: TextStyle(
                            fontSize: 18,
                          ),),
                        RaisedButton(
                            padding: EdgeInsets.all(10),
                            color: Colors.purpleAccent,
                            child: Text("Tentar novamente"),
                            onPressed: () {
                              setState(() {});
                            }
                        ),
                      ],
                    ),
                  );
                }else{
                  return ListaDoacoesRecebidas(doacoes: _jsonListToDoacoes(snapshot.data.body));
                }
              }
            });
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
              onTap: () {
                _onSelectItem(i);
              },
            ),
          )
      );
    }

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
                title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('user');
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()));
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],

      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
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
      body: _getDrawerItemWidget(_selectedDrawerIndex),
//     body: _telaAtual,
    );
  }

}
