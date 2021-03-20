import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sikh_radio/bloc/player_bloc/player_bloc_bloc.dart';
import 'package:sikh_radio/data/model.dart';
import 'package:sikh_radio/size_config.dart';

class RadioListScreen extends StatelessWidget {
  final List<RadioObject> radioList;
  final String title;

  const RadioListScreen({Key key, this.radioList, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white38,
            letterSpacing: 0.25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<PlayerBlocBloc, PlayerBlocState>(
        builder: (context, state) {
          if (state is PlayerStateLoaded) {
            return ListView.builder(
              itemBuilder: (_, i) {
                RadioObject curRadio = radioList[i];
                return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color: Color(0XFF2e2e2e),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
                            ),
                            boxShadow: [
                              new BoxShadow(
                                color: Color(0XFF1c1c1c),
                                offset: Offset(5.0, 5.0),
                                blurRadius: 10.0,
                              ),
                              new BoxShadow(
                                color: Color(0XFF404040),
                                offset: Offset(-5.0, -5.0),
                                blurRadius: 10.0,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(1.5),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  colors: [
                                    Color(0XFF303030),
                                    Color(0XFF1a1a1a)
                                  ]),
                            ),
                            child: ListTile(
                              title: Text(curRadio.name),
                              subtitle: Text(curRadio.desc),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(curRadio.imgUrl),
                              ),
                              trailing: state.radio.radioUrl ==
                                      curRadio.radioUrl
                                  ? state.isPlaying
                                      ? _neuButton(Icons.pause, () {
                                          BlocProvider.of<PlayerBlocBloc>(
                                                  context)
                                              .add(PlayerEventPause());
                                        })
                                      : _neuButton(Icons.play_arrow, () {
                                          BlocProvider.of<PlayerBlocBloc>(
                                                  context)
                                              .add(PlayerEventPlay());
                                        })
                                  : _neuButton(Icons.play_arrow, () {
                                      BlocProvider.of<PlayerBlocBloc>(context)
                                          .add(PlayerEventRadioChanged(
                                              radio: curRadio));
                                    }),
                            ),
                          ),
                        ),
                      ),
                    ));
              },
              itemCount: radioList.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _neuButton(IconData icon, onPressed) {
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
                blurRadius: 10.0,
              ),
              new BoxShadow(
                color: Color(0XFF404040),
                offset: Offset(-5.0, -5.0),
                blurRadius: 10.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [Color(0XFF303030), Color(0XFF1a1a1a)]),
            ),
            child: Icon(
              icon,
              size: 5.4 * Responsive.imageSizeMultiplier,
              color: Colors.white38,
            ),
          ),
        ),
      ),
    );
  }
}
