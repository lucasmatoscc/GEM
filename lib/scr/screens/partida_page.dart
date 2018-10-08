import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../models/partida_model.dart';
import '../const.dart';
import '../widgets/material_list.dart';
import '../models/rodada_model.dart';
import '../widgets/partida_list.dart';

class PartidaPage extends StatelessWidget {  

@override
  Widget build(BuildContext context){
    return  Container(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      color: Colors.white,
      child: FutureBuilder<List<Partida>>(
        future: fetchPartidas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return PartidaWidget(snapshot, index); //;
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

  Future<List<Partida>> fetchPartidas() async {
  final response = await http.get(API_PARTIDAS+'28');

    if (response.statusCode == 200) {
      List<Partida> partidasList = PartidasDaRodada.fromJson(json.decode(response.body)).partidasDaRodada;

       partidasList.sort((a, b) {
          return a.dataHorario.compareTo(b.dataHorario);
        });
    return partidasList;
    } else {
      throw Exception('Erro ao obter lista das partidas da rodada.');
    }
  }  
}