import 'package:flutter/material.dart';

class PlayingNowPage extends StatefulWidget {
  PlayingNowPage({Key key}) : super(key: key);

  @override
  _PlayingNowPageState createState() => _PlayingNowPageState();
}

class _PlayingNowPageState extends State<PlayingNowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("playing now page"),
      ),
    );
  }
}
