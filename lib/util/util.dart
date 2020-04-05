

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


validarEmail(String text) {
  if(text.endsWith("."))
    return false;
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
}

bool validarNome(text){
  return RegExp('[a-zA-Z] [a-zA-Z]').hasMatch(text);
}
bool valida_data(int dia, int mes, int ano) {
  List<int> mes31 = [1, 3,5,7,8,10,12];

  if(ano < 1930 || ano > 2100 || dia <1 || mes <1 || mes >12)
    return false;
  if(mes == 2)
    return dia < 29 || (dia ==29 &&((ano % 4) == 0)&& ((ano % 100)!=0) ||((ano % 400) ==0));
  if(mes31.contains(mes))
    return dia <=31;
  return dia <31;
//{
//  if ((dia >= 1 && dia <= 31) && (mes >= 1 && mes <= 12) && (ano >= 1900 && ano <= 2100)) //verifica se os numeros sao validos
//      {
//    if ((dia == 29 && mes == 2) && ((ano % 4) == 0)) //verifica se o ano e bissexto
//        {
//      return 1;
//    }
//    if (dia <= 28 && mes == 2) //verifica o mes de feveireiro
//        {
//      return 1;
//    }
//    if ((dia <= 30) && (mes == 4 || mes == 6 || mes == 9 || mes == 11)) //verifica os meses de 30 dias
//        {
//      return 1;
//    }
//    if ((dia <=31) && (mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes ==8 || mes == 10 || mes == 12)) //verifica os meses de 31 dias
//        {
//      return 1;
//    }
//    else
//    {
//      return 0;
//    }
//  }
//  else
//  {
//    return 0;
//  }
//}
}