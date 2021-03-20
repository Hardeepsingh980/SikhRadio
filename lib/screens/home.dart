import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sikh_radio/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:sikh_radio/bloc/player_bloc/player_bloc_bloc.dart';
import 'package:sikh_radio/screens/now_playing.dart';
import 'package:sikh_radio/screens/radio_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [SongScreen(), SongScreen(), SongScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.music_note),
        activeColor: CupertinoColors.white,
        inactiveColor: Colors.white38,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.list_bullet),
        activeColor: CupertinoColors.white,
        inactiveColor: Colors.white38,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.music_note_list),
        activeColor: CupertinoColors.white,
        inactiveColor: Colors.white38,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBlocBloc()..add(HomeEventLoading()),
      child: BlocBuilder<HomeBlocBloc, HomeBlocState>(
        builder: (context, state) {
          if (state is HomeStateLoaded) {
            return Scaffold(
                body: BlocProvider(
              create: (context) => PlayerBlocBloc()..add(PlayerEventLoading()),
              child: PersistentTabView(
                context,
                controller: _controller,
                screens: [
                  SongScreen(),
                  RadioListScreen(
                    title: 'LIVE Popular Radio Channels',
                    radioList: state.radioList,
                  ),
                  RadioListScreen(
                    title: 'LIVE Gurdwara Channels',
                    radioList: state.gRadioList,
                  ),
                ],
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Color(0XFF2e2e2e),
                handleAndroidBackButtonPress: true,
                resizeToAvoidBottomInset:
                    true, // This needs to be true if you want to move up the screen when keyboard appears.
                stateManagement: true,
                hideNavigationBarWhenKeyboardShows:
                    true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: ItemAnimationProperties(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation(
                  // Screen tra,
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.neumorphic,
              ),
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
