import 'package:aiqap/feature/playing_now/bloc/audio_bloc.dart';
import 'package:aiqap/feature/playing_now/bloc/audio_event.dart';
import 'package:aiqap/feature/playing_now/bloc/audio_state.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayingNowPage extends StatefulWidget {
  final int index;

  PlayingNowPage({this.index});

  @override
  _PlayingNowPageState createState() => _PlayingNowPageState();
}

class _PlayingNowPageState extends State<PlayingNowPage> {
  AudioBloc audioBloc;
  List<int> heights = [];

  Duration _duration = new Duration();
  Duration _position = new Duration();
  Duration _slider = new Duration(seconds: 0);
  double durationValue;
  bool isPlaying = false;
  bool isLoading = false;

  @override
  void initState() {
    audioBloc = BlocProvider.of<AudioBloc>(context);
    _position = _slider;
    initials();
    audioBloc.audioPlayer.onAudioPositionChanged.listen((event) {
      if (mounted) {
        setState(() {
          _position = event;
        });
      }
    });
    audioBloc.audioPlayer.onDurationChanged.listen(
      (event) {
        if (mounted) {
          setState(
            () {
              _duration = event;
            },
          );
        }
      },
    );
    audioBloc.audioPlayer.onPlayerError.listen((event) {
      print("\nERROR $event\n\n");
    });
    super.initState();
  }

  @override
  dispose() {
    audioBloc.audioPlayer.onAudioPositionChanged.drain();
    audioBloc.audioPlayer.onDurationChanged.drain();
    super.dispose();
  }

  initials() async {
    _duration = Duration(days: 1);
    _position =
        Duration(seconds: await audioBloc.audioPlayer.getCurrentPosition());
  }

  playAudio() async {
    setState(() {
      isLoading = true;
    });
    print("audio");
    if (mounted) {
      setState(() {
        isPlaying = true;
      });
    }
    var result = await audioBloc.audioPlayer.play(
        "http://19a2b2f35111.ngrok.io/media/audio/%D2%9A%D0%90%D0%98%D0%AB%D0%A0%D0%A1%D0%AB%D0%97_%D0%96%D2%B0%D0%9C%D0%90.mp3");

    print("playing result $result");

    setState(() {
      isLoading = false;
    });
    audioBloc.add(PlayAudioEvent());
  }

  pauseAudio() async {
    setState(() {
      isLoading = true;
    });
    audioBloc.add(StopAudioEvent());
    if (mounted) {
      setState(() {
        isPlaying = false;
      });
    }
    var result = await audioBloc.audioPlayer.pause();
    print("pause result $result");

    setState(() {
      isLoading = false;
    });
  }

  stopAudio() async {
    setState(() {
      isLoading = true;
    });
    var result = await audioBloc.audioPlayer.stop();
    print("stop result $result");

    audioBloc.add(StopAudioEvent());
    if (mounted) {
      setState(() {
        isPlaying = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  resume() async {
    setState(() {
      isLoading = true;
    });

    var result = await audioBloc.audioPlayer.resume();
    print("resume result $result");
    audioBloc.add(PlayAudioEvent());
    if (mounted) {
      setState(() {
        isPlaying = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  seek(value) async {
    setState(() {
      isLoading = true;
    });
    print("seeking to $value");
    var result = await audioBloc.audioPlayer.seek(Duration(seconds: value));
    print("seeking result $result");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/abay_path.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.1),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 25,
                                offset: Offset(8, 8),
                                spreadRadius: 3,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 25,
                                offset: Offset(-8, -8),
                                spreadRadius: 3,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/abay_path.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: new LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Мұхтар Әуезов",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Абай жолы",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Slider(
                            value: _position.inSeconds.toDouble(),
                            max: _duration.inSeconds.toDouble(),
                            activeColor: Colors.orange,
                            inactiveColor: Colors.grey,
                            onChanged: (value) => seek(value.toInt()),
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemBuilder: (ctx, i) => Bars(
                                    height: heights[i].toDouble(),
                                    color: i < heights.length / 2
                                        ? Color(0xffc44536)
                                        : Colors.redAccent.withOpacity(0.5),
                                  ),
                                  itemCount: heights.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              timeDisplay(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: Colors.grey,
                                  size: 38,
                                ),
                                onPressed: () {},
                              ),
                              InkWell(
                                onTap: () {
                                  if (isPlaying) {
                                    pauseAudio();
                                  } else {
                                    if (_position.inSeconds > 0) {
                                      resume();
                                    } else {
                                      playAudio();
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  height: ScreenUtil().setHeight(200.0),
                                  width: ScreenUtil().setHeight(200.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(100.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius:
                                              ScreenUtil().setHeight(100.0),
                                        ),
                                      ]),
                                  child: Center(
                                    child: BlocConsumer<AudioBloc, AudioState>(
                                      cubit: audioBloc,
                                      listener: (context, state) {
                                        if (state is PlayingAudioState) {
                                          if (mounted) {
                                            setState(() {
                                              isPlaying = true;
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            setState(() {
                                              isPlaying = false;
                                            });
                                          }
                                        }
                                      },
                                      builder: (context, state) {
                                        if (isLoading) {
                                          return CircularProgressIndicator();
                                        }
                                        if (state is PlayingAudioState) {
                                          return SvgPicture.asset(
                                            "assets/icons/pause.svg",
                                            color:
                                                Color.fromRGBO(192, 96, 70, 1),
                                          );
                                        }
                                        return SvgPicture.asset(
                                          "assets/icons/play.svg",
                                          color: Color.fromRGBO(192, 96, 70, 1),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.skip_next,
                                  color: Colors.grey,
                                  size: 38,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget timeDisplay() {
    int mins = _position.inMinutes;
    int secs = _position.inSeconds % 60;
    int hours = _position.inHours;
    int totalHours = _duration.inHours;
    int totalMins = _duration.inMinutes % 60;
    int totalSecs = _duration.inSeconds % 60;

    String ph = hours < 10 ? "0$hours" : hours.toString();
    String pm = mins < 10 ? "0$mins" : "$mins";
    String ps = secs < 10 ? "0$secs" : "$secs";
    String th = totalHours < 10 ? "0$totalHours" : totalHours.toString();
    String tm = totalMins < 10 ? "0$totalMins" : "$totalMins";
    String ts = totalSecs < 10 ? "0$totalSecs" : "$totalSecs";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$ph:$pm:$ps"),
        Text("$th:$tm:$ts"),
      ],
    );
  }
}

class Bars extends StatelessWidget {
  final double height;
  final Color color;

  Bars({this.height, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      color: Color(0xfffff8ee),
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: Center(
        child: Container(
          height: height,
          color: color,
          width: 4,
        ),
      ),
    );
  }
}
