import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

import 'info_page.dart';

void main() {
  runApp(const ChuckNorrisApp());
}

class ChuckNorrisApp extends StatelessWidget {
  const ChuckNorrisApp({Key? key}) : super(key: key);
  final String title = "Chuck Norris'isms";

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
  late String _joke;
  bool _haveJoke = false;

  Future<void> _getJoke() async {
    Uri url =
        Uri(scheme: 'https', host: 'api.chucknorris.io', path: 'jokes/random');
    final client = HttpClient();
    // bypass expired certs
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(client);
    await http.get(url).then((response) async {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        setState(() {
          _joke = result['value'];
          _haveJoke = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title),
            Image(
              image: const NetworkImage(
                  'https://assets.chucknorris.host/img/avatar/chuck-norris.png'),
              errorBuilder: (context, error, stackTrace) =>
                  SelectableText(error.toString()),
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return const InfoPage(
                      title: 'Info',
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.info),
            label: const Text(''),
          )
        ],
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: _haveJoke
                ? SelectableText(
                    _joke,
                    style: Theme.of(context).textTheme.headline4,
                  )
                : Image.asset('images/chuck-norris.jpg')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getJoke,
        tooltip: 'Next',
        child: const Icon(
          Icons.announcement_rounded,
        ),
      ),
    );
  }
}
