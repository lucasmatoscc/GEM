import 'package:flutter/material.dart';
import 'destaque_page.dart';
import 'partida_page.dart';
import 'mercado_page.dart';
import 'dart:io';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {

  //Definir itens do drawer
  final drawerItems = [
     DrawerItem("Bem-vindo", Icons.home),
     DrawerItem("Mais Escalados da Rodada", Icons.group),        
     DrawerItem("Jogos da Rodada", Icons.date_range), 
  ];

  @override
  HomePageState createState() => HomePageState();  
}

class HomePageState extends State<HomePage> {
  
  //Definir página inicial
  int selectedDrawerIndex = 0;

  //Método para retonar a tela correspondente ao drawer
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Center(child: MercadoPage());
      case 1:
        return DestaquePage();
      case 2:
        return PartidaPage();  
      default:
        return Text("Error");
    }
  }
  
  //Método para selecionar o drawer
  onSelectItem(int index) {
    setState(() => selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    //Montar a lista do drawer
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
         ListTile(
          leading:  Icon(d.icon),
          title:  Text(d.title),
          selected: i == selectedDrawerIndex,
          onTap: () => onSelectItem(i),
        )
      );
    }
    //Adicionando outros itens no drawer que não possuem tela
    drawerOptions.add( Divider());
    drawerOptions.add( ListTile(
                          title:  Text("Fechar Aplicativo"),
                          leading:   Icon(Icons.close),
                          onTap: () => exit(0),
                      ));

    return  Scaffold(
      appBar:  AppBar(
         title:  Text(widget.drawerItems[selectedDrawerIndex].title),
         elevation: 2.0,
      ),
      drawer:  Drawer(
        child:  Column(
          children: <Widget>[
             UserAccountsDrawerHeader(
                accountName:  Text("Seu Nome"), accountEmail:  Text("seunome@gmail.com")),
             Column(children: drawerOptions)
          ],
        ),
      ),
      body: getDrawerItemWidget(selectedDrawerIndex),
    );
  }
}