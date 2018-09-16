import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class Atleta {
  String nome;
  String urlFoto;
  Atleta({this.nome, this.urlFoto});
}

class MaisEscalados {
  Atleta atleta;
  String qtdEscalacoes;
  String clube;
  String posicao;

  MaisEscalados({this.atleta, this.qtdEscalacoes, this.clube, this.posicao});
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mais Escalados da Rodada',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Mais Escalados da Rodada'),
          elevation: 0.0,
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new Text("Bem-vindo"),
              ),
              new Divider(),
              new ListTile(
                  title: new Text("Fechar aplicativo"),
                  trailing: new Icon(Icons.close),
                  onTap: () => exit(0)),
            ],
          ),
        ),
        body: new Container(
          margin: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 5.0, top:5.0),
          color: Colors.black12,
          child: new FutureBuilder<List<MaisEscalados>>(
            future: fetchMaisEscalados(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return new ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      return new Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2.0, top:2.0),
                          child: new Material(
                              borderRadius: new BorderRadius.circular(6.0),
                              elevation: 0.5,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      width: 40.0,
                                      height: 40.0,
                                      margin: const EdgeInsets.only(left: 3.0, right: 0.0, bottom: 0.0, top:0.0),
                                      decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(const Radius.circular(4.0)),
                                      image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                  snapshot.data[index].atleta.urlFoto)
                                      )
                                    )
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 5.0, right: 0.0, bottom: 0.0, top:0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                             Text(snapshot.data[index].atleta.nome, style: TextStyle(fontWeight: FontWeight.bold)),
                                             Text(snapshot.data[index].clube),
                                             Text(snapshot.data[index].posicao, style: TextStyle(color: Colors.black54)),
                                          ],
                                        )
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 0.0, right: 3.0, bottom: 0.0, top:0.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text('${index+1}º', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text('${snapshot.data[index].qtdEscalacoes} escalações')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          )
                      );
                    }
                );
              }
              else if(snapshot.hasError){
                return new Text("${snapshot.error}");
              }
              return new  Center(
                child: new CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }


  Future<List<MaisEscalados>> fetchMaisEscalados() async {
    final response = await http.get('https://api.cartolafc.globo.com/mercado/destaques');

    if (response.statusCode == 200) {

      List responseJson = json.decode(response.body.toString());
      List<MaisEscalados> listaMaisEscalados = criarListaMaisEscalados(responseJson);

      return listaMaisEscalados;
    } else {
      throw Exception('Erro ao obter lista dos jogadores mais escalados');
    }
  }


  List<MaisEscalados> criarListaMaisEscalados(List dados){

    List<MaisEscalados> lista = new List();

    for(int i = 0; i < dados.length; i++){

      final formatoEscalacoes = new NumberFormat("###,###.###", "pt-br");

      Atleta atleta = new Atleta();
      atleta.nome = dados[i]["Atleta"]["apelido"];
      atleta.urlFoto = dados[i]["Atleta"]["foto"].toString().replaceAll("FORMATO", "140x140");
      String qtdEscalacoes = formatoEscalacoes.format(dados[i]["escalacoes"]);
      String clube = dados[i]["clube"];
      String posicao = dados[i]["posicao"];

      MaisEscalados jogador = new MaisEscalados(atleta: atleta , qtdEscalacoes: qtdEscalacoes, clube: clube, posicao: posicao);

      lista.add(jogador);
    }
    return lista;
  }
}


