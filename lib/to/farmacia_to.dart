class FarmaciaTO {
  String email;
  int id;
  String nome;
  String cnpj;

  FarmaciaTO({this.email, this.id, this.nome, this.cnpj});

  FarmaciaTO.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    nome = json['nome'];
    cnpj = json['cnpj'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cnpj'] = this.cnpj;
    return data;
  }
}
