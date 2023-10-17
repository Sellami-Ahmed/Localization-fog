import 'package:flutter/material.dart';
import 'package:localization_client/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // on below line we are specifying title of our app
      title: 'GFG',
      // on below line we are hiding debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // on below line we are specifying theme
        primarySwatch: Colors.green,
      ),
      // First screen of our app
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _textController = TextEditingController();

  void _onGoButtonPressed() {
    String serverAddr = _textController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(serverAddr: serverAddr)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Server'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    labelText: 'Enter server address',
                    hintText: "192.168.x.x:8080"),
              ),
            ),
            ElevatedButton(onPressed: _onGoButtonPressed, child: Text("Go")),
          ],
        ),
      ),
    );
  }
}
