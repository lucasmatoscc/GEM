import 'package:flutter/material.dart';

class DestaqueWidget extends StatelessWidget{

  final AsyncSnapshot snapshot;
  final int index;
 
  DestaqueWidget(this.snapshot, this.index);

  Widget build(context){
    return  Padding(padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child:  
    Column(children: <Widget>[
       
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[ 
              //Imagem jogador
              Container(
                width: 52.0, 
                height: 52.0,
                margin: const EdgeInsets.only(top: 0.0),
                decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(const Radius.circular(50.0)),
                              //color: Colors.grey[200],
                              image: DecorationImage(
                                  fit: BoxFit.fill,                                  
                                  image: NetworkImage(snapshot.data[index].atleta.urlFoto)))),
              //Detalhes jogador
              Expanded(
                child:
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 0.0, bottom: 0.0, top: 0.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Nome Atleta
                      Text(snapshot.data[index].atleta.nome,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
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
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                    //Classificação
                    Text('${index + 1}º', style: TextStyle(fontWeight: FontWeight.bold,)),
                    //Quantidad de Escalações
                    Text('${snapshot.data[index].qtdEscalacoes} escalações')
                  ],
                ),
              ),
              
            ],
          ),
          Divider(indent: 60.0, color: Colors.black38, height:5.0,),]));
  }
}