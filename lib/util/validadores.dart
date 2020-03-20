

int _gerarDigitoVerificador(List<int> digits) {
  int baseNumber = 0;
  for (var i = 0; i < digits.length; i++) {
    baseNumber += digits[i] * ((digits.length + 1) - i);
  }
  int verificationDigit = baseNumber * 10 % 11;
  return verificationDigit >= 10 ? 0 : verificationDigit;
}

bool validarCPF(String cpf){
  if(cpf.length < 11)
    return false;
  List<int> sanitizedCPF = cpf
      .replaceAll(new RegExp(r'\.|-'), '')
      .split('')
      .map((String digit) => int.parse(digit))
      .toList();
  return !_blacklistedCPF(sanitizedCPF.join()) &&
      sanitizedCPF[9] == _gerarDigitoVerificador(sanitizedCPF.getRange(0, 9).toList()) &&
      sanitizedCPF[10] == _gerarDigitoVerificador(sanitizedCPF.getRange(0, 10).toList());
}

bool _blacklistedCPF(String cpf) {
  return
    cpf == '11111111111' ||
        cpf == '22222222222' ||
        cpf == '33333333333' ||
        cpf == '44444444444' ||
        cpf == '55555555555' ||
        cpf == '66666666666' ||
        cpf == '77777777777' ||
        cpf == '88888888888' ||
        cpf == '99999999999';
}

String _formatCPF(List<int> n) =>
    '${n[0]}${n[1]}${n[2]}.${n[3]}${n[4]}${n[5]}.${n[6]}${n[7]}${n[8]}-${n[9]}${n[10]}';

bool validarSenha(String senha){
  return senha.length >7 && senha.length <17;
}


validarEmail(text) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
}

bool validarNome(text){
  return RegExp('[a-zA-Z] [a-zA-Z]').hasMatch(text);
}
