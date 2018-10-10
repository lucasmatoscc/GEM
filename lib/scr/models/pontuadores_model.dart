import '../models/pontuacaorodada_model.dart';

class Pontuadores{
  String rodada;
  String total_atletas;
  List<PontuacaoRodada> pontuadocaoList;

  Pontuadores({this.rodada, this.total_atletas, this.pontuadocaoList});

  factory Pontuadores.fromJson(Map<String, dynamic> json)  {
    var listPontuadores = json['atletas'] as List;
    List<PontuacaoRodada> listPontuacao = new List<PontuacaoRodada>();
    for (int i = 0; i < listPontuadores.length; i++){
      listPontuacao[i].apelido = listPontuadores[i]["apelido"].toString();
      listPontuacao[i].urlFoto = listPontuadores[i]["foto"].toString();
      listPontuacao[i].pontuacao = listPontuadores[i]["pontuacao"].toString();
    }
    return Pontuadores(
      rodada: json["rodada"].toString(),
      total_atletas: json["total_atletas"].toString(),
      pontuadocaoList: listPontuacao,
    );
  }
}
