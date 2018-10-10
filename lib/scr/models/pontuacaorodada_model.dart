
class PontuacaoRodada{
  String apelido;
  String pontuacao;
  String urlFoto;

  PontuacaoRodada({this.apelido, this.pontuacao, this.urlFoto});

factory PontuacaoRodada.fromJson(Map<String, dynamic> json){

    return PontuacaoRodada(
        apelido: json["apelido"].toString(),
        pontuacao: json["pontuacao"].toString(),
        urlFoto: json["urlFoto"].toString(),
    );
  }
}