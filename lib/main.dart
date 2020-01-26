import 'package:flutter/material.dart';
import 'package:tamu_hack_2020/fire_index_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fire Index'),
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
  final fireIndexBloc = FireIndexBloc();

  final _latTextFieldController = TextEditingController();
  final _lonTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _latTextFieldController.text = '-30.9546892';
    _lonTextFieldController.text = '121.164108';
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Fire Index"),
      ),
      body: StreamBuilder(
        stream: fireIndexBloc.fireIndexStream,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.hasData) {
            // here we would render the google map with the fire index
            return Center(
              child: Text(
                  "Fire index for lat:${_latTextFieldController.text}, lon:${_lonTextFieldController.text} is \n fire-index: ${snapshot.data}"),
            );
          } else {
            // you request a fire index by calling
            // fireIndexBloc.requestFireIndex(lat, lon)
            return Column(
              children: <Widget>[
                Text('Enter longitude:'),
                TextField(
                  controller: _lonTextFieldController,
                ),
                Text('Enter latitudes:'),
                TextField(
                  controller: _latTextFieldController,
                ),
                FlatButton(
                  child: Text('find fire index'),
                  color: Colors.lightBlue,
                  onPressed: () {
                    double lon = double.parse(_lonTextFieldController.text);
                    double lat = double.parse(_latTextFieldController.text);

                    fireIndexBloc.requestFireIndex(lat, lon);
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}
