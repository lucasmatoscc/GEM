
import 'package:flutter/material.dart';
import 'package:gem/DraggableScrollbar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  //provide the same scrollController for list and draggableScrollbar
  final ScrollController controller = ScrollController();
  var altura;
  int qtdItens = 4;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('CARTOLA FC - GEM'),
        ),
        //DraggableScrollbar builds Stack with provided Scrollable List of Grid
        body: new DraggableScrollbar(
          child: _buildGrid(),
          heightScrollThumb: 70.0,
          controller: controller,
          qtdItens: qtdItens,
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      controller: controller,//scrollController is final in this stateless widget
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      padding: EdgeInsets.zero,
      itemCount: qtdItens,

      itemBuilder: (context, index) {
        var figura = 'assets/alinhadosfc.png';
        var src = new AssetImage(figura);
        Image image = new Image(image: src, width: 200.0, height: 200.0);
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(2.0),
          color: Colors.grey[300],
          //I've add index to grid cells to see more clear how it scrolls
          child: new Center(child: image),

          //new Text("FOTO DO JOGADOR")),
        );
      },
    );
  }
}

