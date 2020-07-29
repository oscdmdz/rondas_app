import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rondas_app/registry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rondas campesinas - Melgar',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Registro de ronderos - Melgar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _state_form = 0;
  var _dni = "";
  Registry registry = Registry(
      code: " ",
      dni: " ",
      id: 0,
      firstName: " ",
      lastName: " ",
      photo: "http://rondas.munimelgar.gob.pe/staticfiles/img/new_logo.png",
      name: " ");

  String url = "http://rondas.munimelgar.gob.pe/registry/";

  void updateButtonState(String text) {
    setState(() {
      _dni = text;
    });
  }

  Future<Registry> getRegistry() async {
    final response = await http.get(url + _dni);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      registry = Registry.fromJson(json.decode(response.body)[0]);
      setState(() {
        _state_form = 1;
      });
      return registry;
    } else {
      setState(() {
        _state_form = 0;
      });
      // Si esta respuesta no fue OK, lanza un error.
      //throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 0.0,
                left: 40.0,
                right: 40.0,
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (value) => updateButtonState(value),
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        validator: (value) {
                          setState(() {
                            _state_form = 1;
                          });
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  if (_state_form == 1)
                    Column(children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.all(20.0),
                        child: new Image.network(
                          registry.photo,
                          height: 160.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    ]),
                  if (_state_form == 1)
                    Column(
                      children: <Widget>[
                        Text("DNI: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Text(registry.dni,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200)),
                      ],
                    ),
                  if (_state_form == 1)
                    Column(
                      children: <Widget>[
                        Text("Nombres: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Text(registry.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200)),
                      ],
                    ),
                  if (_state_form == 1)
                    Column(
                      children: <Widget>[
                        Text("Apellido Paterno: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Text(registry.firstName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200)),
                      ],
                    ),
                  if (_state_form == 1)
                    Column(
                      children: <Widget>[
                        Text("Apellido Materno: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Text(registry.lastName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200)),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getRegistry();
        },
        tooltip: 'Validar rondero',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
