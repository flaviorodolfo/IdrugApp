class ColetaTO {
  String dosagem;
  FarmaciaTO farmaciaTO;
  int id;
  Paciente paciente;
  String produto;

  ColetaTO(
      {this.dosagem, this.farmaciaTO, this.id, this.paciente, this.produto});

  ColetaTO.fromJson(Map<String, dynamic> json) {
    dosagem = json['dosagem'];
    farmaciaTO = json['farmaciaTO'] != null
        ? new FarmaciaTO.fromJson(json['farmaciaTO'])
        : null;
    id = json['id'];
    paciente = json['paciente'] != null
        ? new Paciente.fromJson(json['paciente'])
        : null;
    produto = json['produto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dosagem'] = this.dosagem;
    if (this.farmaciaTO != null) {
      data['farmaciaTO'] = this.farmaciaTO.toJson();
    }
    data['id'] = this.id;
    if (this.paciente != null) {
      data['paciente'] = this.paciente.toJson();
    }
    data['produto'] = this.produto;
    return data;
  }
}

class FarmaciaTO {
  int id;
  String nome;
  String cnpj;

  FarmaciaTO({this.id, this.nome, this.cnpj});

  FarmaciaTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cnpj = json['cnpj'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cnpj'] = this.cnpj;
    return data;
  }
}

class Paciente {
  int id;

  Paciente({this.id});

  Paciente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
