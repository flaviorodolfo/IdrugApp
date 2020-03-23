



class DoacaoTO {
  String cpf;
  String data;
  String dosagem;
  int id;
  String produto;

  DoacaoTO({this.cpf, this.data, this.dosagem, this.id, this.produto});

  DoacaoTO.fromJson(Map<String, dynamic> json) {
    cpf = json['cpf'];
    data = json['data'];
    dosagem = json['dosagem'];
    id = json['id'];
    produto = json['produto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['data'] = this.data;
    data['dosagem'] = this.dosagem;
    data['id'] = this.id;
    data['produto'] = this.produto;
    return data;
  }
}