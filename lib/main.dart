import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ChuckNorrisApp());
}

class ChuckNorrisApp extends StatelessWidget {
  const ChuckNorrisApp({Key? key}) : super(key: key);
  final String title = "Chuck Norris'isms";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.blueGrey,
      ),
      home: _HomePage(title: title),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  String _joke = '';

  Future<void> _getJoke() async {
    Uri url =
        Uri(scheme: 'https', host: 'api.chucknorris.io', path: 'jokes/random');
    var result = json.decode(await http.read(url));
    setState(() {
      _joke = result['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text(widget.title),
          const Image(
            image: NetworkImage(
                'https://assets.chucknorris.host/img/avatar/chuck-norris.png'),
          ),
        ],
      )),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  _joke,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getJoke,
        tooltip: 'Next',
        child: const Icon(Icons.announcement_rounded),
      ),
    );
  }
}
