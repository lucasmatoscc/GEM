import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
            child: new FutureBuilder<StatusMercado>(
              future: fetchUsersFromGitHub(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return new Container(
                            width: 40.0,
                            height: 40.0,
                           // margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2.0, top: 2.0),
                            child: new Material(
                              //  borderRadius: new BorderRadius.circular(6.0),
                              color: Colors.green[600],
                                //elevation: 2.0,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                     // margin: const EdgeInsets.only(left: 0.0, right: 3.0, bottom: 0.0, top:0.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                              new Text(''' Rodada Nº ${snapshot.data.rodada_atual}''',
                                                  style: new TextStyle(fontWeight: FontWeight.bold, color:  Colors.white)),
                                              new Text('''  Mercado: ${snapshot.data.dsMercado}''',
                                                  style: new TextStyle(fontWeight: FontWeight.bold, color:  Colors.white)),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                        );
                      }
                  );
                } else if (snapshot.hasError) {
                  return new Text("${snapshot.error}");
                }
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(
                          Icons.home,
                          size: 150.0,
                          color: Colors.black12
                      ),
                      new Text('Settings tab content')
                    ],
                  ),
                );
                // By default, show a loading spinner
                return new Center(
                 child: new  CircularProgressIndicator(),
                );
              },
            ),

  );

  Future <StatusMercado> fetchUsersFromGitHub() async {
    final response = await http.get('https://api.cartolafc.globo.com/mercado/status');
    print(response.body);
    var responseJson = json.decode(response.body.toString());
    StatusMercado status = StatusMercado.fromJson(responseJson);
    //List<StatusMercado> userList = new List<StatusMercado>();
    if(status.status_mercado == 1){
      status.dsMercado = "Aberto";
    }else{
      status.dsMercado = "Fechado";
    }
   // userList.add(status);
    return status;
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



