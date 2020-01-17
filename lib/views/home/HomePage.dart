import 'package:app_music/models/Music.dart';
import 'package:app_music/utils/ComponentUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  /* Propriétés de la page */
  final String title;

  /* Constructeur */
  HomePage(this.title, {Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List<Music> _musics = <Music>[];
  Music currentMusic;

  @override
  void initState() {
    _musics.add(new Music('Theme Swift', 'CodeBee', 'assets/music1.jpg', 'https://codabee.com/wp-content/uploads/2018/06/un.mp3'));
    _musics.add(new Music('Theme Flutter', 'CodeBee', 'assets/music2.jpg', 'https://codabee.com/wp-content/uploads/2018/06/deux.mp3'));
    this.currentMusic = _musics.first;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.title),
        backgroundColor: Colors.grey[900],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Card(
              elevation: 9.0,
              child: new Container(
                width: MediaQuery.of(context).size.height/2.5,
                child: Image.asset(this.currentMusic.imagePath),
              ),
            ),
            ComponentUtils.buildStyledText(this.currentMusic.title, 1.5),
            ComponentUtils.buildStyledText(this.currentMusic.author, 0.8),
            new SizedBox(
              height: 80,
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ComponentUtils.buildStyledText('00:00:00', 0.5),
                  ComponentUtils.buildStyledText('00:00:50', 0.5),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


}
