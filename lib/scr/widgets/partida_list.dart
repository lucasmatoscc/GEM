import 'package:flutter/material.dart';

class PartidaWidget extends StatelessWidget{

  final AsyncSnapshot snapshot;
  final int index;
 
  PartidaWidget(this.snapshot, this.index);

  Widget build(context){
    return    
    Column(                
      children:<Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(snapshot.data[index].diaPartida),
            Padding(
              padding: EdgeInsets.only(bottom: 0.0,top: 0.0, left: 10.0, right: 0.0),
              child:Text(snapshot.data[index].data)
            ), 
            Padding(
              padding: EdgeInsets.only(bottom: 0.0,top: 0.0, left: 10.0, right: 10.0),
              child:Text(snapshot.data[index].local)
            ),
            Text(snapshot.data[index].horario),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[                      
            Container(alignment: Alignment.centerRight,
              width: 30.0, child: Text(snapshot.data[index].clubeMandante.posicao.toString() + 'º')),
            Container(
              width: 30.0, 
              height: 30.0,
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Image.network(snapshot.data[index].clubeMandante.urlEscudo60x60)
            ),
            Text(snapshot.data[index].clubeMandante.abreviacao),
            Text(snapshot.data[index].placarMandante.toString(),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            Text(' X '),
            Text(snapshot.data[index].placarVisitante.toString(),style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            Text(snapshot.data[index].clubeVisitante.abreviacao),                      
            Container(
              width: 30.0, 
              height: 30.0,
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Image.network(snapshot.data[index].clubeVisitante.urlEscudo60x60)
            ),
            Container(alignment: Alignment.centerLeft,
              width: 30.0,
              child: Text(snapshot.data[index].clubeVisitante.posicao.toString() + 'º')),
          ],
        ),
      ],
    );
  }
}