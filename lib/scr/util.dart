 class Util{

  static String obterDiaSemana(DateTime data){
    switch (data.weekday) {
      case 1: 
        return 'Seg';
      case 2:
        return 'Ter';
      case 3:
        return 'Qua';
      case 4:
        return 'Qui';
      case 5:
        return 'Sex';
      case 6:
        return 'Sáb';
      case 7:
        return 'Dom';
    }
  }
}