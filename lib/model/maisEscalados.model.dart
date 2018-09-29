import 'atleta.model.dart';
import 'package:intl/intl.dart';



class MaisEscalados {
  
  final Atleta atleta;  
  final String qtdEscalacoes;
  final String clube;
  final String posicao;

  MaisEscalados({this.atleta, this.qtdEscalacoes, this.clube, this.posicao});

  //Ler json e converter para objeto MaisEscalados
  factory MaisEscalados.fromJson(Map<String, dynamic> json){
    Atleta atleta = new Atleta(nome:    json["atleta"]["apelido"].toString(),
                               urlFoto: json["Atleta"]["foto"].toString().replaceAll("FORMATO", "140x140"));

    final formatoEscalacoes = new NumberFormat("###,###.###", "pt-br");
;
    return MaisEscalados(atleta: atleta,
                         qtdEscalacoes: formatoEscalacoes.format(json["escalacoes"].toString()),
                         clube:  json["clube"].toString(),
                         posicao:  json["posicao"].toString());
  }
}

