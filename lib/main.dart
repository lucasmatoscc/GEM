import 'package:flutter/material.dart';
import 'screen/maisEscalados.screen.dart';
import 'dart:io';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,     
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
      );
    
  }
}

class DrawerItem {
  String titulo;
  IconData icone;
  DrawerItem(this.titulo, this.icone);
}

class MyHomePage extends StatefulWidget {

  //Definir itens do drawer
  final drawerItems = [
     DrawerItem("Bem-vindo", Icons.home),
     DrawerItem("Mais Escalados da Rodada", Icons.group),        
  ];

  @override
  _MyHomePageState createState() =>  _MyHomePageState();  
}

class _MyHomePageState extends State<MyHomePage> {
  
  //Definir página inicial
  int selectedDrawerIndex = 0;

  //Método para retonar a tela correspondente ao drawer
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return  Center(child: Text("Bem-vindo"));
      case 1:
        return  WidgetMaisEscalados();
      default:
        return  Text("Error");
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
          leading:  Icon(d.icone),
          title:  Text(d.titulo),
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
         title:  Text(widget.drawerItems[selectedDrawerIndex].titulo),
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