import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../const.dart';
import '../models/pontuacaorodada_model.dart';
import '../models/pontuadores_model.dart';
import '../widgets/pontuacaorodada_list.dart';

class Pontuadores_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      color: Colors.white,
      child: FutureBuilder<List<PontuacaoRodada>>(
        future: fetchPontuadores(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return PontuacaoRodadaWidget(snapshot, index); //;
                }
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<PontuacaoRodada>> fetchPontuadores() async{
    final response = await http.get(API_PONTUADORES);
    var responseJson = json.decode(response.body.toString());
    List<PontuacaoRodada> listaPontuadores = criarListaPontuadores(responseJson);
    return listaPontuadores;
  }

  List<PontuacaoRodada> criarListaPontuadores(Pontuadores pontuadores){
    List<PontuacaoRodada> lista = new List<PontuacaoRodada>();
    for (int i=0; i < pontuadores.pontuadocaoList.length; i++){
      PontuacaoRodada pontuacaoRodada = new PontuacaoRodada();
      pontuacaoRodada.apelido = pontuadores.pontuadocaoList[i].apelido;
      pontuacaoRodada.urlFoto = pontuadores.pontuadocaoList[i].urlFoto;
      pontuacaoRodada.pontuacao = pontuadores.pontuadocaoList[i].pontuacao;
      lista.add(pontuacaoRodada);
    }
  }

}
