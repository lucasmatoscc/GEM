import 'package:intl/intl.dart';

class Mercado {
  int rodada;
  String dataFechamento;
  String horaFechamento;
  String situacao;
  String qtdTimesEscalados;

  Mercado({this.rodada, this.dataFechamento, this.horaFechamento, this.situacao, this.qtdTimesEscalados});


factory Mercado.fromJson(Map<String, dynamic> json){
  
  DateTime fechamento = new DateTime.fromMillisecondsSinceEpoch(json['fechamento']['timestamp'] * 1000);
  
  var formatoData = new DateFormat('dd/MM/yyyy');
  var formatoHora = new DateFormat('HH:mm');
  var formatoEscalacoes = new NumberFormat("###,###.###", "pt-br");
  var situacao    = 'Fechado';

  if(json['status_mercado'] == 1) {
    situacao = 'Aberto';
  }

  return Mercado(rodada: json['rodada_atual'],
                 situacao : situacao,
                 dataFechamento: formatoData.format(fechamento),
                 horaFechamento: formatoHora.format(fechamento),                 
                 qtdTimesEscalados: formatoEscalacoes.format(json['times_escalados']));               

  }
}