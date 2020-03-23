class PacienteTO {
  String email;
  int id;
  String nome;
  String cpf;

  PacienteTO({this.email, this.id, this.nome, this.cpf});

  PacienteTO.fromJson(Map<String, dynamic> json) {

    email = json['email'];
    id = json['id'] ;
    nome = json['nome'];
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    return data;
  }
}
