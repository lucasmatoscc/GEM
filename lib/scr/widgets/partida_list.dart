import 'package:flutter/material.dart';

class PartidaWidget extends StatelessWidget{

  final AsyncSnapshot snapshot;
  final int index;
 
  PartidaWidget(this.snapshot, this.index);

  Widget build(context){
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ 
              //Local partida
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[  
                  Text(snapshot.data[index].data + ' ' + snapshot.data[index].horario),
                  Row (
                children: <Widget> [
                  Text(snapshot.data[index].clubeMandante.abreviacao),
                  Container(
                    width: 35.0, 
                    height: 35.0,
                    child: Image.network(snapshot.data[index].clubeMandante.urlEscudo60x60)),
                  Text(snapshot.data[index].placarMandante.toString()),
                  Text(' X '),
                  Text(snapshot.data[index].placarVisitante.toString()),
                  Container(
                    width: 35.0, 
                    height: 35.0,
                    child: Image.network(snapshot.data[index].clubeVisitante.urlEscudo60x60)),
                  Text(snapshot.data[index].clubeVisitante.abreviacao)
                ]
              ),
                  Text(snapshot.data[index].local),
                ]
              ),
                            
            ]
    );
  }
}