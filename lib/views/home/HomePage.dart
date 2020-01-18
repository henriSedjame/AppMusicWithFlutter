import 'package:app_music/models/Music.dart';
import 'package:app_music/utils/ComponentUtils.dart';
import 'package:audioplayer2/audioplayer2.dart';
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
  Duration currentMusicPosistion;
  Duration currentMusicTotalDuration;
  AudioPlayerState currentMusicState = AudioPlayerState.PAUSED;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    _musics.add(new Music('Theme Swift', 'CodeBee', 'assets/music1.jpg', 'https://codabee.com/wp-content/uploads/2018/06/un.mp3'));
    _musics.add(new Music('Theme Flutter', 'CodeBee', 'assets/music2.jpg', 'https://codabee.com/wp-content/uploads/2018/06/deux.mp3'));
    this.currentMusic = _musics.first;
    this.resetCurrentMusicPosition();
    this.initAudioPlayer();
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
              elevation: 11.0,
              child: new Container(
                width: MediaQuery.of(context).size.height/2.3,
                child: Image.asset(this.currentMusic.imagePath),
              ),
            ),
            new SizedBox(
              height: 10.0
            ),
            ComponentUtils.buildStyledText(this.currentMusic.title, 1.5),
            ComponentUtils.buildStyledText(this.currentMusic.author, 0.8),
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ComponentUtils.buildIconButton(Icons.fast_rewind, 30.0, this.isFirstMusic() ? null : this._rewind),
                  ComponentUtils.buildIconButton(this.isPlaying() ? Icons.pause : Icons.play_arrow , 55.0, this.isPlaying() ? this.pause : this.play),
                  ComponentUtils.buildIconButton(Icons.fast_forward, 30.0, this.isLastMusic() ? null : this._forward),
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ComponentUtils.buildStyledText(this.formatDuration(this.currentMusicPosistion), 0.5),
                  ComponentUtils.buildStyledText(this.formatDuration(this.audioPlayer?.duration ?? new Duration(seconds: 0)), 0.5),
                ],
              ),
            ),
            new Slider(
                value: this.currentMusicPosistion.inSeconds.toDouble(),
                min: 0.0,
                max: 22.0,
                activeColor: Colors.grey[900],
                inactiveColor: Colors.white,
                onChanged: (double pos){
                  setState(() {
                    this.audioPlayer.seek(pos);
                  });
                }),
          ],
        ),
      ),
    );
  }

  String formatDuration(Duration duration) => duration.toString().substring(0, 7);

  void _forward() {
    setState(() {
      var nextIndex = this._musics.indexOf(this.currentMusic) + 1;
      this.stop();
      this.currentMusic = this._musics[nextIndex];
      this.resetCurrentMusicPosition();
      this.play();
    });
  }

  void _rewind() {
    setState(() {
      this.stop();
      if (this.currentMusicPosistion > new Duration(seconds: 0)) {
        this.resetCurrentMusicPosition();
        this.audioPlayer.seek(this.currentMusicPosistion.inSeconds.toDouble());
        this.play();
      } else {
        var previousIndex = this._musics.indexOf(this.currentMusic) - 1;
        this.currentMusic = this._musics[previousIndex];
        this.resetCurrentMusicPosition();
        this.play();
      }

    });
  }

  void resetCurrentMusicPosition() {
    this.currentMusicPosistion = new Duration(seconds: 0);
  }

  void initAudioPlayer() {
    this.audioPlayer = new AudioPlayer();

    this.audioPlayer
        .onAudioPositionChanged
        .listen(
            (pos){
              setState(() {
                this.currentMusicPosistion = pos;
              });
            }
        );

    this.audioPlayer
        .onPlayerStateChanged
        .listen(
            (state){
              setState(() {
                this.currentMusicState = state;
              });
            }
        );
  }

  Future play() async => await this.audioPlayer.play(this.currentMusic.url);

  Future pause() async => await this.audioPlayer.pause();

  Future stop() async => await this.audioPlayer.stop();

  bool isFirstMusic() => this.currentMusic == this._musics.first;

  bool isLastMusic() => this.currentMusic == this._musics.last;

  bool isPlaying() => this.currentMusicState == AudioPlayerState.PLAYING;

  bool isPaused() => this.currentMusicState == AudioPlayerState.PAUSED;
}
