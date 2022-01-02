import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/programmer.jpg',
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Linkify(
                text: 'Another fine mess by http://Footeware.ca',
                onOpen: _openUrl,
                linkStyle: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 18,
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openUrl(link) async {
    if (await canLaunch(link.url)) {
      await launch(
        link.url,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $link';
    }
  }
}
