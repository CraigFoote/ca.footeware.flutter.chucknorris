import 'dart:convert';
import 'dart:io';

import 'package:chuck_norris/custom_theme.dart';
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
      theme: CustomTheme.darkTheme,
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
    Uri url = Uri(
      scheme: 'https',
      host: 'api.chucknorris.io',
      path: 'jokes/random',
    );
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
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        actions: [
          OutlinedButton.icon(
            label: const Text(
              'Next',
            ),
            onPressed: () => setState(
              () {
                _getJoke();
              },
            ),
            icon: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
          OutlinedButton.icon(
            label: const Text(
              'Info',
            ),
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
            icon: const Icon(
              Icons.arrow_forward_rounded,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: _haveJoke
                ? SelectableText(
                    _joke,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  )
                : Image.asset('images/chuck-norris.jpg')),
      ),
    );
  }
}
