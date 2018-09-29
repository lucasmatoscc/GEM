import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../model/maisEscalados.model.dart';
import '../model/atleta.model.dart';
import 'package:gem_app/const.dart';

class WidgetMaisEscalados extends StatelessWidget {
@override
  Widget build(BuildContext context){
    return new Scaffold(
    floatingActionButton:  new FloatingActionButton(
          child: new Icon(Icons.refresh),
          onPressed: () {
           
          }),
    body: new  Container(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 5.0, top: 5.0),
      color: Colors.black12, //Cor de fundo
      child: FutureBuilder<List<MaisEscalados>>(
        future: fetchMaisEscalados(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(                        
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2.0, top: 2.0),
                  child: Material(
                    borderRadius: new BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0),topRight:  Radius.circular(10.0)),
                    elevation: 0.5,
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[ 
                        //Imagem jogador
                        Container(
                          width: 40.0, 
                          height: 40.0,
                          margin: const EdgeInsets.only(left: 3.0, right: 0.0, bottom: 0.0, top: 0.0),
                          decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(const Radius.circular(10.0)),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(snapshot.data[index].atleta.urlFoto)))),
                        //Detalhes jogador
                        Expanded(
                          child:
                            Container(
                              margin: const EdgeInsets.only(left: 5.0, right: 0.0, bottom: 0.0, top: 0.0),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Nome Atleta
                                Text(snapshot.data[index].atleta.nome,
                                     style: TextStyle(fontWeight: FontWeight.bold)),
                                //Clube Atleta
                                Text(snapshot.data[index].clube),
                                //Posição Atleta
                                Text(snapshot.data[index].posicao,
                                     style: TextStyle(color: Colors.grey)),
                                ],
                              )),
                        ),
                        //Quantidade de Escalações
                        Container(
                          margin: const EdgeInsets.only(left: 0.0, right: 3.0, bottom: .0, top: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                             children: <Widget>[
                              //Classificação
                              Text('${index + 1}º', style: TextStyle(fontWeight: FontWeight.bold)),
                              //Quantidad de Escalações
                              Text('${snapshot.data[index].qtdEscalacoes} escalações')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            });
              } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
              } else {
                  return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
        ),
      )
    )      
      ;
    }
    Future<List<MaisEscalados>> fetchMaisEscalados() async {
    final response = await http.get(API_DESTAQUES);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body.toString());
      List<MaisEscalados> listaMaisEscalados =  criarListaMaisEscalados(responseJson);

      return listaMaisEscalados;
    } else {
      throw Exception('Erro ao obter lista dos jogadores mais escalados');
    }
  }

  List<MaisEscalados> criarListaMaisEscalados(List dados) {
    List<MaisEscalados> lista = new List();

    for (int i = 0; i < dados.length; i++) {
      final formatoEscalacoes = new NumberFormat("###,###.###", "pt-br");

      Atleta atleta = new Atleta();
      atleta.nome = dados[i]["Atleta"]["apelido"];
      atleta.urlFoto = dados[i]["Atleta"]["foto"].toString().replaceAll("FORMATO", "140x140");
      String qtdEscalacoes = formatoEscalacoes.format(dados[i]["escalacoes"]);
      String clube = dados[i]["clube"];
      String posicao = dados[i]["posicao"];

      MaisEscalados jogador = new MaisEscalados(
          atleta: atleta,
          qtdEscalacoes: qtdEscalacoes,
          clube: clube,
          posicao: posicao);

      lista.add(jogador);
    }
    return lista;
  }
  }