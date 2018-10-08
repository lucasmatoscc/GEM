import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../const.dart';
import '../models/mercado_model.dart';


class MercadoPage extends StatelessWidget {  

@override
  Widget build(BuildContext context){
    return  
      FutureBuilder<Mercado>(
        future: fetchMercado(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {            
            return Column( 
             mainAxisAlignment: MainAxisAlignment.center,
              children: 
                <Widget>[
                  Text('Mercado: ${snapshot.data.situacao.toString()}'),
                  Text('Rodada atual: ${snapshot.data.rodada.toString()}'),
                  Text('Times escalados: ${snapshot.data.qtdTimesEscalados.toString()}'),
                  Text('Mercado aberto até: ${snapshot.data.dataFechamento.toString()} ${snapshot.data.horaFechamento.toString()}'),
                ]
            );
          }            
           else if (snapshot.hasError) {
              return Text("${snapshot.error}");
          } else {
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        }            
    );
  }

  Future<Mercado> fetchMercado() async {
    final response = await http.get(API_MERCADO);
     if (response.statusCode == 200) {
      Mercado mercado = Mercado.fromJson(json.decode(response.body));      
      return mercado;
     }else {
      throw Exception('Erro ao obter informações sobre o mercado.');
    } 
  }

}   
