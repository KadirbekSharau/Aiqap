import 'package:aiqap/feature/audioProvider/audio_provider.dart';
import 'package:aiqap/feature/book_page/ui/widgets/book_page_widgets.dart';
import 'package:aiqap/feature/main_page/ui/widgets/widgets.dart';
import 'package:aiqap/feature/playing_now/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PlayingNowPage extends StatefulWidget {
  @override
  _PlayingNowPageState createState() => _PlayingNowPageState();
}

class _PlayingNowPageState extends State<PlayingNowPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Stack(
            children: [
              value.currentBook.img == null
                  ? placeholderImage()
                  : networkImage(value.currentBook.img),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15.0,
                  sigmaY: 15.0,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageContainer(value.currentBook),
                  SizedBox(height: ScreenUtil().setHeight(200.0)),
                  Container(
                    height: ScreenUtil().setHeight(1000.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenUtil().setHeight(50.0)),
                        topRight: Radius.circular(ScreenUtil().setHeight(50.0)),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: ScreenUtil().setHeight(100.0),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(80.0)),
                        titleText(value.currentBook),
                        SizedBox(height: ScreenUtil().setHeight(40.0)),
                        authorText(value.currentBook.author),
                        SizedBox(height: ScreenUtil().setHeight(80.0)),
                        Slider(
                          value: value.position == null
                              ? 0
                              : value.position.inMilliseconds.toDouble(),
                          max: value.totalDuration == null
                              ? 100
                              : value.totalDuration.inMilliseconds.toDouble(),
                          activeColor: Colors.orange,
                          inactiveColor: Colors.grey,
                          onChanged: (newPos) {
                            value.seek(Duration(milliseconds: newPos.toInt()));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            timeDisplay(value.position),
                            timeDisplay(value.totalDuration),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(100.0)),
                        controllButtons(),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget controllButtons() {
    return Consumer<AudioProvider>(
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                value.fastBack();
              },
              child: SvgPicture.asset(
                "assets/icons/back.svg",
                color: Colors.black54,
                width: ScreenUtil().setHeight(70.0),
              ),
            ),
            InkWell(
              onTap: () {
                value.initBook(value.currentBook);
                if (value.playerState != "PLAY") {
                  value.playAudio();
                } else {
                  value.pauseAudio();
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
                        blurRadius: ScreenUtil().setHeight(100.0),
                      ),
                    ]),
                child: Center(
                  child: SvgPicture.asset(
                    value.playerState != "PLAY"
                        ? "assets/icons/play.svg"
                        : "assets/icons/pause.svg",
                    color: Color.fromRGBO(192, 96, 70, 1),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                value.fastForward();
              },
              child: SvgPicture.asset(
                "assets/icons/forward.svg",
                color: Colors.black54,
                width: ScreenUtil().setHeight(70.0),
              ),
            )
          ],
        );
      },
    );
  }

  Widget timeDisplay(Duration position) {
    if (position == null) {
      return Text("00:00:00");
    }
    int hours = position.inHours;
    int mins = position.inMinutes - position.inHours * 60;
    int secs = position.inSeconds - position.inMinutes * 60;
    String th = hours < 10 ? "0$hours" : "$hours";
    String tm = mins < 10 ? "0$mins" : "$mins";
    String ts = secs < 10 ? "0$secs" : "$secs";
    return Text("$th:$tm:$ts");
  }
}
