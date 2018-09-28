import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './tabs/home.dart' as _firstTab;
import './tabs/dashboard.dart' as _secondTab;
import './tabs/settings.dart' as _thirdTab;
import './screens/about.dart' as _aboutPage;
import './screens/support.dart' as _supportPage;
import './screens/maisescalados.dart' as _maisescaladospage;
import './screens/mercado.dart' as _mercadopage;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Starter',
      theme: new ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.green, backgroundColor: Colors.white
      ),
      home: new Tabs(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/about': return new FromRightToLeft(
            builder: (_) => new _aboutPage.About(),
            settings: settings,
          );
          case '/maisescalados': return new FromRightToLeft(
            builder: (_) => new _maisescaladospage.MaisEscalados(),
            settings: settings,
          );
          case '/support': return new FromRightToLeft(
            builder: (_) => new _supportPage.Support(),
            settings: settings,
          );
          case '/mercado': return new FromRightToLeft(
            builder: (_) => new _mercadopage.Mercado(),
            settings: settings,
          );
        }
      },
      // routes: <String, WidgetBuilder> {
      //   '/about': (BuildContext context) => new _aboutPage.About(),
      // }
    );
  }
}



class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0,
            )
          ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}

class TabsState extends State<Tabs> {
  
  PageController _tabController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new AppBar(
      title: new Text(
        'Cartola FC - GEM',
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body: new PageView(
      controller: _tabController,
      onPageChanged: onTabChanged,
      children: <Widget>[
        new _firstTab.Home(),
        new _secondTab.Dashboard(),
        new _thirdTab.Settings()
      ],
    ),

    //Tabs
    bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.blueGrey,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new BottomNavigationBar(
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
    ),

    //Drawer
    drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 120.0,
            child: new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: new Color(0xFFECEFF1),
              ),
              child: new Center(
                child: new FlutterLogo(
                  colors: Colors.blueGrey,
                  size: 54.0,
                ),
              ),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.chat),
            title: new Text('Support'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/support');
            }
          ),
          new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('Mais Escalados'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/maisescalados');
              }
          ),
          new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('Mercado'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/mercado');
              }
          ),
          new ListTile(
            leading: new Icon(Icons.info),
            title: new Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/about');
            }
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
        ],
      )
    )
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
      break;

      case 1:
        this._title_app = TabItems[1].title;
      break;

      case 2:
        this._title_app = TabItems[2].title;
      break;
    }
  }

  Future<List<StatusMercado>> fetchUsersFromGitHub() async {
    final response = await http.get('https://api.cartolafc.globo.com/mercado/status');
    print(response.body);
    var responseJson = json.decode(response.body.toString());
    var status = StatusMercado.fromJson(responseJson);
    List<StatusMercado> userList = new List<StatusMercado>();
    if(status.status_mercado == 1){
      status.dsMercado = "Mercado Aberto";
    }else{
      status.dsMercado = "Mercado Fechado";
    }
    userList.add(status);
    return userList;
  }

  List<StatusMercado> createUserList(List data){
    List<StatusMercado> list = new List();
    for (int i = 0; i < data.length; i++) {
      int rodada_atual = data[i]["rodada_atual"];
      print ("AQUI:"+rodada_atual.toString());
      StatusMercado statusMercado = new StatusMercado(
          rodada_atual: rodada_atual
      );
      list.add(statusMercado);
    }
    return list;
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Dashboard', icon: Icons.dashboard),
  const TabItem(title: 'Settings', icon: Icons.settings)
];


class StatusMercado{
  int rodada_atual;
  int status_mercado;
  String dsMercado;
  StatusMercado({this.rodada_atual, this.status_mercado, this.dsMercado});
  StatusMercado.fromJson(Map<String, dynamic> json)
      : rodada_atual = json['rodada_atual'],
        status_mercado = json['status_mercado'];
}