class MedicamentoDisponivelTO {
  String cnpj;
  String dosagem;
  int id;
  String produto;

  MedicamentoDisponivelTO({this.cnpj, this.dosagem, this.id, this.produto});

  MedicamentoDisponivelTO.fromJson(Map<String, dynamic> json) {
    cnpj = json['cnpj'];
    dosagem = json['dosagem'];
    id = json['id'];
    produto = json['produto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cnpj'] = this.cnpj;
    data['dosagem'] = this.dosagem;
    data['id'] = this.id;
    data['produto'] = this.produto;
    return data;
  }
}