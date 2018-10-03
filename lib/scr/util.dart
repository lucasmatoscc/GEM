 class Util{

  static String obterDiaSemana(DateTime data){
    switch (data.weekday) {
      case 1: 
        return 'SEG';
      case 2:
        return 'TER';
      case 3:
        return 'QUA';
      case 4:
        return 'QUI';
      case 5:
        return 'SEX';
      case 6:
        return 'SÁB';
      case 7:
        return 'DOM';
    }
  }
}