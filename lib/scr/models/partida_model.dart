import 'clube_model.dart';
import 'package:intl/intl.dart';

class Partida {
  Clube clubeMandante;
  Clube clubeVisitante;
  int placarMandante;
  int placarVisitante;
  String local;
  String data;
  String horario;

  Partida({this.clubeMandante,
           this.clubeVisitante,
           this.placarMandante,
           this.placarVisitante,
           this.local,
           this.data,
           this.horario});

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
    
    return Partida(
      clubeMandante : clubeMandante,
      clubeVisitante : clubeVisitante,
      placarMandante: json['placar_oficial_mandante'] as int,
      placarVisitante: json['placar_oficial_visitante'] as int,
      local: json['local'] as String,
      data: formatoData.format(dataHorario),
      horario: formatoHora.format(dataHorario)
    );
 }
}