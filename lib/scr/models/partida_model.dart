import 'clube_model.dart';
import 'package:intl/intl.dart';
import '../util.dart';


class Partida {
  Clube clubeMandante;
  Clube clubeVisitante;
  String placarMandante;
  String placarVisitante;
  String local;
  String data;
  String horario;
  DateTime dataHorario;
  String diaPartida;

  Partida({this.clubeMandante,
           this.clubeVisitante,
           this.placarMandante,
           this.placarVisitante,
           this.local,
           this.data,
           this.horario,
           this.dataHorario,
           this.diaPartida});

  factory Partida.fromJson(Map<String, dynamic> json) {
   
    Clube clubeMandante = new Clube();
    clubeMandante.id = json['clube_casa_id'] as int;
    clubeMandante.posicao = json['clube_casa_posicao'] as int;
    
    Clube clubeVisitante = new Clube();
    clubeVisitante.id = json['clube_visitante_id'] as int;
    clubeVisitante.posicao =  json['clube_visitante_posicao'] as int;

    final formatoData = new DateFormat('dd/MM/yyyy');
    final formatoHora = new DateFormat('HH:mm');
       
    String date =  json['partida_data'];
    String dateWithT = date.replaceAll('-', '');
    dateWithT = dateWithT.replaceAll(':', '');
    dateWithT = dateWithT.replaceAll(' ', '');
    dateWithT = dateWithT.substring(0, 8) + 'T' + dateWithT.substring(8);
    DateTime dataHorario = DateTime.parse(dateWithT);

    String placarMandante = json['placar_oficial_mandante'] == null ? '-': json['placar_oficial_mandante'].toString();
    String placarVisitante = json['placar_oficial_visitante'] == null ? '-': json['placar_oficial_visitante'].toString();
    
    
    return Partida(
      clubeMandante: clubeMandante,
      clubeVisitante: clubeVisitante,
      placarMandante: placarMandante,
      placarVisitante: placarVisitante,
      local: json['local'] as String,
      data: formatoData.format(dataHorario),
      horario: formatoHora.format(dataHorario),
      //valida:  json['valida'] as bool
      dataHorario: dataHorario,
      diaPartida:  Util.obterDiaSemana(dataHorario)
    );
 }
}