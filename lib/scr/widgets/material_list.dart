import 'package:flutter/material.dart';

class MaterialList extends StatelessWidget{

  final Widget conteudo;

  MaterialList(this.conteudo);
 
  Widget build(context) {
    return Container(                        
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 2.5, top: 2.5),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        elevation: 1.0,
        child: conteudo,
      )
    );
  }
}