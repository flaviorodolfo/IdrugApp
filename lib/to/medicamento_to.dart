
class MedicamentoTO {
  String dosagem;
  String produto;
  String tarja;

  MedicamentoTO({this.dosagem, this.produto, this.tarja});

  MedicamentoTO.fromJson(Map<String, dynamic> json) {
    dosagem = json['dosagem'];
    produto = json['produto'];
    tarja = json['tarja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dosagem'] = this.dosagem;
    data['produto'] = this.produto;
    data['tarja'] = this.tarja;
    return data;
  }
}