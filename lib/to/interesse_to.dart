class InteresseTO {
  String cpf;
  String dataInteresse;
  String dosagem;
  int id;
  String produto;

  InteresseTO(
      {this.cpf, this.dataInteresse, this.dosagem, this.id, this.produto});

  InteresseTO.fromJson(Map<String, dynamic> json) {
    cpf = json['cpf'];
    dataInteresse = json['dataInteresse'];
    dosagem = json['dosagem'];
    id = json['id'];
    produto = json['produto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['dataInteresse'] = this.dataInteresse;
    data['dosagem'] = this.dosagem;
    data['id'] = this.id;
    data['produto'] = this.produto;
    return data;
  }
}

