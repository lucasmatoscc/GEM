import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MaisEscalados extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(
    //App Bar
    appBar: new AppBar(
      title: new Text(
        'Mais Escalados',
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),
    //Content of tabs
    body: new Container(
      child: new FutureBuilder<List<Escalados>>(
        future: fetchUsersFromGitHub(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return new Container(
                      width: 40.0,
                      height: 40.0,
                      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2.0, top: 2.0),
                      child: new Material(
                          borderRadius: new BorderRadius.circular(6.0),
                          elevation: 2.0,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Image(image: new NetworkImage(snapshot.data[index].escudo_clube)),
                              new Image(image: new NetworkImage(snapshot.data[index].atleta.ft_jogador)),
                              new Divider(),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5.0, right: 0.0, bottom: 0.0, top: 0.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(''' ${snapshot.data[index].atleta.apelido}''',
                                          style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new Text('''${snapshot.data[index].posicao}''',
                                          style: new TextStyle(fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 3.0, bottom: 0.0, top:0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    new Text('''${snapshot.data[index].cont}º ''',
                                        style: new TextStyle(fontWeight: FontWeight.bold)),
                                    new Text('''Escalações: ${snapshot.data[index].qtd_escalacoes}  ''',
                                        style: new TextStyle(fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                            ],
                          )
                      )
                  );
                }
            );
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return new CircularProgressIndicator();
        },
      ),
    ),
  );

  Future<List<Escalados>> fetchUsersFromGitHub() async {
    final response = await http.get('https://api.cartolafc.globo.com/mercado/destaques');
    print(response.body);
    List responseJson = json.decode(response.body.toString());
    List<Escalados> userList = createUserList(responseJson);
    return userList;
  }

  List<Escalados> createUserList(List data){
    List<Escalados> list = new List();
    for (int i = 0; i < data.length; i++) {
      String posicao = data[i]["posicao"];
      int qtd_escalacoes = data[i]["escalacoes"];
      String escudo_clube = data[i]["escudo_clube"];
      String ft_jogador;
      int cont;
      cont = i+1;
      if (data[i]["Atleta"]["foto"] == null){
        ft_jogador = "";
      }else{
        ft_jogador = data[i]["Atleta"]["foto"].toString().replaceAll("FORMATO", "140x140");
      }
      String apelido = data[i]["Atleta"]["apelido"].toString();
      Atleta atleta = new Atleta(
        apelido: apelido,
        ft_jogador: ft_jogador
      );
      print ("AQUI:"+ft_jogador);
      Escalados escalados = new Escalados(
          atleta: atleta,
          posicao: posicao,
          qtd_escalacoes: qtd_escalacoes,
          escudo_clube: escudo_clube,
          ft_jogador: ft_jogador,
          apelido: apelido,
          cont: cont
      );
      list.add(escalados);
    }
    return list;
  }
}

class Escalados{
  Atleta atleta;
  String posicao;
  int qtd_escalacoes;
  String escudo_clube;
  String ft_jogador;
  String apelido;
  int cont;
  Escalados({this.atleta, this.posicao,this.qtd_escalacoes,this.escudo_clube,this.ft_jogador, this.apelido,this.cont});
}

class Atleta{
  String apelido;
  String ft_jogador;
  Atleta({this.apelido,this.ft_jogador});
}

