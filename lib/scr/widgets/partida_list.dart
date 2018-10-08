import 'package:flutter/material.dart';

class PartidaWidget extends StatelessWidget{

  final AsyncSnapshot snapshot;
  final int index;
 
  PartidaWidget(this.snapshot, this.index);

  Widget build(context){
    return  
    Container(padding: const EdgeInsets.only(right: 15.0, left: 15.0),
      child: Column(                
        children:<Widget>[       
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(snapshot.data[index].diaPartida),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child:Text(snapshot.data[index].data,)
              ),
              Text(snapshot.data[index].horario),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0,top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[                      
                Container(alignment: Alignment.centerRight,
                  width: 30.0, child: Text(snapshot.data[index].clubeMandante.posicao.toString() + 'º')),
                Container(
                  width: 35.0, 
                  height: 35.0,
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Image.network(snapshot.data[index].clubeMandante.urlEscudo60x60)
                ),
                Text(snapshot.data[index].clubeMandante.abreviacao),
                Text(snapshot.data[index].placarMandante, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                Text(' X '),
                Text(snapshot.data[index].placarVisitante, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                Text(snapshot.data[index].clubeVisitante.abreviacao),                      
                Container(
                  width: 35.0, 
                  height: 35.0,
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Image.network(snapshot.data[index].clubeVisitante.urlEscudo60x60)
                ),
                Container(alignment: Alignment.centerLeft,
                  width: 30.0,
                  child: Text(snapshot.data[index].clubeVisitante.posicao.toString() + 'º')
                ),
              ],
            )
          ),
          Text(snapshot.data[index].local,),        
          Divider( color: Colors.black38),
        ],
      )
    );
  }
}