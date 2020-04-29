import 'package:drawablenotepadflutter/const.dart';
import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:drawablenotepadflutter/routes/intro/intro_samples.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitRoute extends StatefulWidget {
  InitRoute({Key key}) : super(key: key);

  static const String routeName = "ListRoute";

  @override
  _InitRouteState createState() => _InitRouteState();
}

class _InitRouteState extends State<InitRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Settings.defaultColor,
      body: Center(
        child: Image(
          image: AssetImage("assets/icon.png"),
          fit: BoxFit.fill,
          width: 170,
          height: 200,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isTutorialDone().then((done) => {
          if (done)
            {AppNavigator.navigateToNoteList(context)}
          else
            {
              IntroSamples.getSampleNote(context).then(
                  (value) => {AppNavigator.navigateToIntro(context, value)})

              /*new Future.delayed(const Duration(milliseconds: 500))
                  .then((value) => {AppNavigator.navigateToIntro(context)})*/
            }
        });
  }

  setTutorialDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.showTutorialSharedPrefKey, true);
  }

  Future<bool> isTutorialDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(Constants.showTutorialSharedPrefKey) ?? false);
  }

  void _showSearch() {
    //TODO TBD
  }
}
