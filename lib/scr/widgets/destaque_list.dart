import 'package:flutter/material.dart';

class DestaqueWidget extends StatelessWidget{

  final AsyncSnapshot snapshot;
  final int index;
 
  DestaqueWidget(this.snapshot, this.index);

  Widget build(context){
    return Row(
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
          );
  }
}