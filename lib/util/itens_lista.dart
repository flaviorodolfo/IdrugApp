import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';





class Interesse{
  var nomeMedicamento;
  var dataPedido;
  var dosagem;
  var idInteresse;
  Interesse(this.nomeMedicamento,this.dataPedido, this.dosagem,  this.idInteresse);
}

List<Interesse> montarDe(){
  var lista = <Interesse>[];
  for(int i =0;i<10;i++)
    lista.add(new Interesse("Medicamento $i", "Aguardando Desde $i$i/$i$i/$i$i$i$i",null,null));
  return lista;
}
List<DoacoesRecebidas> montarDoa(){
  var lista = <DoacoesRecebidas>[];
  for(int i =0;i<10;i++)
    lista.add(new DoacoesRecebidas("Nome medicamento $i", "Data doacao: $i","ENDEREÇO", "DataDOacao"));
  return lista;
}






class DoacoesRecebidas{
  var nomeMedicamento;
  var dataDoacao;
  var nomeFarmacia;
  var endereco;
  DoacoesRecebidas(this.nomeMedicamento,this.dataDoacao,this.nomeFarmacia,this.endereco);

}





List<ListaColeta> montarColeta(){
  var lista = <ListaColeta>[];
  for(int i =0;i<10;i++)
    lista.add(new ListaColeta("Medicamento $i","Farmacia x$i","Ola mundo $i","Rua Major Teles de Menezes, 630, São Crsitóvão, Sergipe","Datalimite $i"));
  return lista;
}


class ListaColeta{
  var medicamento;
  var nomeFarmacia;
  var codigoColeta;
  var endereco;
  var dataLimite;
  ListaColeta(this.medicamento,this.nomeFarmacia,this.codigoColeta,this.endereco,this.dataLimite);

}