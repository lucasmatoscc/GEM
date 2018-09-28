import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Mercado extends StatelessWidget {
  @override
  Widget build (BuildContext context) => new Scaffold(
    //App Bar
    appBar: new AppBar(
      title: new Text(
        'Mercado',
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),
    //Content of tabs
    body: new Container(
      child: new FutureBuilder<List<StatusMercado>>(
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
                              new Text(''' Rodada Nº: ${snapshot.data[index].rodada_atual}
                              Mercado: ${snapshot.data[index].dsMercado}''',
                                  style: new TextStyle(fontWeight: FontWeight.bold)),
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

  Future<List<StatusMercado>> fetchUsersFromGitHub() async {
    final response = await http.get('https://api.cartolafc.globo.com/mercado/status');
    print(response.body);
    var responseJson = json.decode(response.body.toString());
    var status = StatusMercado.fromJson(responseJson);
    List<StatusMercado> userList = new List<StatusMercado>();
    if(status.status_mercado == 1){
      status.dsMercado = "Mercado Aberto";
    }else{
      status.dsMercado = "Mercado Fechado";
    }
    userList.add(status);
    return userList;
  }

  List<StatusMercado> createUserList(List data){
    List<StatusMercado> list = new List();
    for (int i = 0; i < data.length; i++) {
      int rodada_atual = data[i]["rodada_atual"];
      print ("AQUI:"+rodada_atual.toString());
      StatusMercado statusMercado = new StatusMercado(
          rodada_atual: rodada_atual
      );
      list.add(statusMercado);
    }
    return list;
  }
}

class StatusMercado{
  int rodada_atual;
  int status_mercado;
  String dsMercado;
  StatusMercado({this.rodada_atual, this.status_mercado, this.dsMercado});
  StatusMercado.fromJson(Map<String, dynamic> json)
      : rodada_atual = json['rodada_atual'],
        status_mercado = json['status_mercado'];
}


