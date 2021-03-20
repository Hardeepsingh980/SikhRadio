import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sikh_radio/bloc/player_bloc/player_bloc_bloc.dart';
import 'package:sikh_radio/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  double firstOffset = 5.0;
  double secondOffset = -5.0;

  var _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<PlayerBlocBloc>(context);

    MediaNotification.setListener('pause', () {
      _bloc.add(PlayerEventPause());
    });

    MediaNotification.setListener('play', () {
      _bloc.add(PlayerEventPlay());
    });

    MediaNotification.setListener('next', () {
      _bloc.add(PlayerEventNext());
    });

    MediaNotification.setListener('prev', () {
      _bloc.add(PlayerEventNext());
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<PlayerBlocBloc, PlayerBlocState>(
      builder: (context, state) {
        if (state is PlayerStateLoaded) {
          return Scaffold(
            // resizeToAvoidBottomPadding: false,
            backgroundColor: Color(0XFF2e2e2e),
            appBar: NeumorphicAppBar(
              centerTitle: true,
              title: Text(
                'SIKH RADIO',
                style: TextStyle(
                  color: Colors.white38,
                  letterSpacing: 0.25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 4 * Responsive.heightMultiplier,
                        horizontal: 6 * Responsive.widthMultiplier),
                    child: Row(
                      children: <Widget>[
                        // _neuButton(Icons.arrow_back),
                        Spacer(),
                        Text(
                          "PLAYING NOW (LIVE)",
                          style: TextStyle(
                            color: Colors.white38,
                            letterSpacing: 0.25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        // _neuButton(Icons.menu),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.5 * Responsive.heightMultiplier,
                  ),
                  width > 450
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50 * Responsive.imageSizeMultiplier,
                              width: 50 * Responsive.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFF212121),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Color(0XFF1c1c1c),
                                    offset: Offset(15.0, 15.0),
                                    blurRadius: 22.0,
                                  ),
                                  new BoxShadow(
                                    color: Color(0XFF404040),
                                    offset: Offset(-15.0, -15.0),
                                    blurRadius: 22.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                            state.radio.imgUrl)),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: state.radio.name,
                                        style: TextStyle(
                                          fontSize:
                                              3 * Responsive.textMultiplier,
                                          color: Colors.white70,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      WidgetSpan(
                                          child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 1.3 *
                                                Responsive.heightMultiplier),
                                        child: Icon(
                                          Icons.explicit,
                                          color: Colors.white54,
                                          size: 4.6 *
                                              Responsive.imageSizeMultiplier,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5 * Responsive.heightMultiplier,
                                ),
                                Text(
                                  state.radio.type == 0
                                      ? state.radio.desc
                                      : "Playing Live ${state.radio.name}",
                                  style: TextStyle(
                                    fontSize: 1.5 * Responsive.textMultiplier,
                                    color: Colors.white54,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  height: 2 * Responsive.heightMultiplier,
                                ),
                                Row(
                                  children: [
                                    _neuControls(FontAwesomeIcons.backward, () {
                                      _bloc.add(PlayerEventNext());
                                    }),
                                    SizedBox(
                                      width: 2 * Responsive.widthMultiplier,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          if (state.isPlaying) {
                                            _bloc.add(PlayerEventPause());
                                          } else {
                                            _bloc.add(PlayerEventPlay());
                                          }
                                        },
                                        child: _neuPausePlay(state.isPlaying
                                            ? FontAwesomeIcons.pause
                                            : FontAwesomeIcons.play)),
                                    SizedBox(
                                      width: 2 * Responsive.widthMultiplier,
                                    ),
                                    _neuControls(FontAwesomeIcons.forward, () {
                                      _bloc.add(PlayerEventNext());
                                    }),
                                  ],
                                ),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal:
                                //           12 * Responsive.widthMultiplier),
                                //   child: Row(
                                //     children: <Widget>[
                                //       _neuControls(FontAwesomeIcons.backward,
                                //           () {
                                //         _bloc.add(PlayerEventNext());
                                //       }),
                                //       Spacer(),
                                //       GestureDetector(
                                //           onTap: () {
                                //             if (state.isPlaying) {
                                //               _bloc.add(PlayerEventPause());
                                //             } else {
                                //               _bloc.add(PlayerEventPlay());
                                //             }
                                //           },
                                //           child: _neuPausePlay(state.isPlaying
                                //               ? FontAwesomeIcons.pause
                                //               : FontAwesomeIcons.play)),
                                //       Spacer(),
                                //       _neuControls(FontAwesomeIcons.forward,
                                //           () {
                                //         _bloc.add(PlayerEventNext());
                                //       }),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              height: 60 * Responsive.imageSizeMultiplier,
                              width: 60 * Responsive.imageSizeMultiplier,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFF212121),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Color(0XFF1c1c1c),
                                    offset: Offset(15.0, 15.0),
                                    blurRadius: 22.0,
                                  ),
                                  new BoxShadow(
                                    color: Color(0XFF404040),
                                    offset: Offset(-15.0, -15.0),
                                    blurRadius: 22.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                            state.radio.imgUrl)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4 * Responsive.heightMultiplier,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: state.radio.name,
                                    style: TextStyle(
                                      fontSize: 3.6 * Responsive.textMultiplier,
                                      color: Colors.white70,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                    margin: EdgeInsets.only(
                                        bottom:
                                            1.3 * Responsive.heightMultiplier),
                                    child: Icon(
                                      Icons.explicit,
                                      color: Colors.white54,
                                      size:
                                          4.6 * Responsive.imageSizeMultiplier,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5 * Responsive.heightMultiplier,
                            ),
                            Text(
                              state.radio.type == 0
                                  ? state.radio.desc
                                  : "Playing Live ${state.radio.name}",
                              style: TextStyle(
                                fontSize: 1.9 * Responsive.textMultiplier,
                                color: Colors.white54,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 2 * Responsive.heightMultiplier,
                            ),
                            SizedBox(
                              height: 2 * Responsive.heightMultiplier,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12 * Responsive.widthMultiplier),
                              child: Row(
                                children: <Widget>[
                                  _neuControls(FontAwesomeIcons.backward, () {
                                    _bloc.add(PlayerEventNext());
                                  }),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        if (state.isPlaying) {
                                          _bloc.add(PlayerEventPause());
                                        } else {
                                          _bloc.add(PlayerEventPlay());
                                        }
                                      },
                                      child: _neuPausePlay(state.isPlaying
                                          ? FontAwesomeIcons.pause
                                          : FontAwesomeIcons.play)),
                                  Spacer(),
                                  _neuControls(FontAwesomeIcons.forward, () {
                                    _bloc.add(PlayerEventNext());
                                  }),
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _neuControls(IconData faIcon, onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0XFF2e2e2e),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
            ),
            boxShadow: [
              new BoxShadow(
                color: Color(0XFF1c1c1c),
                offset: Offset(5.0, 5.0),
//                          spreadRadius: -5.0,
                blurRadius: 10.0,
              ),
              new BoxShadow(
                color: Color(0XFF404040),
                offset: Offset(-5.0, -5.0),
//                          spreadRadius: -5.0,
                blurRadius: 10.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Color(0XFF303030), Color(0XFF1a1a1a)]),
            ),
            child: Padding(
              padding: EdgeInsets.all(8 * Responsive.imageSizeMultiplier),
              child: FaIcon(
                faIcon,
                color: Colors.white54,
                size: 3.6 * Responsive.imageSizeMultiplier,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _neuPausePlay(IconData faIcon) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0XFF2e2e2e),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
          ),
          boxShadow: [
            new BoxShadow(
              color: Color(0XFF4a4a4a),
              offset: Offset(firstOffset, firstOffset),
              blurRadius: 6.0,
            ),
            new BoxShadow(
              color: Color(0XFF404040),
              offset: Offset(secondOffset, secondOffset),
              blurRadius: 6.0,
            ),
          ]),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red[700],
            width: 1.0,
          ),
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Colors.red[900], Colors.deepOrange[700]]),
        ),
        child: Padding(
          padding: EdgeInsets.all(9.6 * Responsive.imageSizeMultiplier),
          child: FaIcon(
            faIcon,
            color: Colors.white70,
            size: 3.6 * Responsive.imageSizeMultiplier,
          ),
        ),
      ),
    );
  }
}
