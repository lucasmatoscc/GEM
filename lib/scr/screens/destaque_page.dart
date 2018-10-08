import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/destaque_model.dart';
import '../models/atleta_model.dart';
import '../const.dart';
import '../widgets/destaque_list.dart';
import '../widgets/material_list.dart';

class DestaquePage extends StatelessWidget {  

@override
  Widget build(BuildContext context){
    return  Container(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      color: Colors.white,
      child: FutureBuilder<List<Destaque>>(
        future: fetchDestaques(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return DestaqueWidget(snapshot, index); //;
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

  Future<List<Destaque>> fetchDestaques() async {
  final response = await http.get(API_DESTAQUES);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body.toString());
      List<Destaque> listaDestaques =  criarListaDestaques(responseJson);

      return listaDestaques;
    } else {
      throw Exception('Erro ao obter lista dos jogadores mais escalados');
    }
  }

  List<Destaque> criarListaDestaques(List dados) {
    List<Destaque> lista = new List();

    for (int i = 0; i < dados.length; i++) {
      final formatoEscalacoes = new NumberFormat("###,###.###", "pt-br");

      Atleta atleta = new Atleta();
      atleta.nome = dados[i]["Atleta"]["apelido"];
      atleta.urlFoto = dados[i]["Atleta"]["foto"].toString().replaceAll("FORMATO", "140x140");
      String qtdEscalacoes = formatoEscalacoes.format(dados[i]["escalacoes"]);
      String clube = dados[i]["clube"];
      String posicao = dados[i]["posicao"];

      Destaque jogador = new Destaque(
          atleta: atleta,
          qtdEscalacoes: qtdEscalacoes,
          clube: clube,
          posicao: posicao);

      lista.add(jogador);
    }
    return lista;
  }
  }