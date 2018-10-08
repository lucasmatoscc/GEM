import 'partida_model.dart';
import 'clube_model.dart';

class PartidasDaRodada {

  int numRodada;
  
  List<Partida> partidasDaRodada;
  
  PartidasDaRodada({this.numRodada, this.partidasDaRodada});

  factory PartidasDaRodada.fromJson(Map<String, dynamic> parsedJson){
    var listPartidas   = parsedJson['partidas'] as List;
    var listInfoClubes = parsedJson['clubes'];
    var numRodada      = parsedJson['rodada'];

    List<Partida> partidasList = listPartidas.map((i) => Partida.fromJson(i)).toList();
   
    for (int i = 0; i < partidasList.length; i++){
      Partida partida = new Partida();
      partida = partidasList[i];
    
      Clube clubeMandante = new Clube();
      clubeMandante = Clube.fromJson(listInfoClubes[partida.clubeMandante.id.toString()]);

      Clube clubeVisitante = new Clube();
      clubeVisitante = Clube.fromJson(listInfoClubes[partida.clubeVisitante.id.toString()]);

      partidasList[i].clubeMandante = clubeMandante;
      partidasList[i].clubeVisitante = clubeVisitante;
    }

    return PartidasDaRodada(
      numRodada: numRodada,
      partidasDaRodada: partidasList
    );
  }
}


