import 'package:flutter/material.dart';

class PontuacaoRodadaWidget extends StatelessWidget{

  final AsyncSnapshot snapshot;
  final int index;

  PontuacaoRodadaWidget(this.snapshot, this.index);

  @override
  Widget build(BuildContext context) {
    Column(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(left: 10.0, right: 0.0, bottom: 0.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Nome Atleta
              Text(snapshot.data[index].apelido.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
              Text(snapshot.data[index].pontuacao.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
            ],
          )),
    ],);
  }

}