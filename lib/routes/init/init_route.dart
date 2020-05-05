import 'package:drawablenotepadflutter/const.dart';
import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:drawablenotepadflutter/routes/intro/intro_samples.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../translations.dart';

class InitRoute extends StatefulWidget {
  InitRoute({Key key}) : super(key: key);

  static const String routeName = "ListRoute";

  @override
  _InitRouteState createState() => _InitRouteState();
}

class _InitRouteState extends State<InitRoute> {
  bool nonTutorialTransition = false;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: AppLocalizations.of(context).translate('appTitle'),
      primaryColor: Theme.of(context).primaryColor.value,
    ));

    return Scaffold(
        backgroundColor: Settings.defaultColor,
        body: Stack(
          children: <Widget>[
            Center(
              child: Image(
                image: AssetImage("assets/icon.png"),
                fit: BoxFit.fill,
                width: 170,
                height: 200,
              ),
            ),
            AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: nonTutorialTransition ? 1.0 : 0.0,
                onEnd: () => AppNavigator.navigateToNoteList(context),
                child: Column(
                  children: [
                    AppBar(
                      title: Text(AppLocalizations.of(context)
                          .translate('notesListRouteToolbarTitle')),
                      actions: <Widget>[
                        IconButton(icon: Icon(Icons.search)),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _isTutorialDone().then((done) => {
          if (done)
            {
              setState(() {
                nonTutorialTransition = true;
              })
            }
          else
            {
              IntroSamples.getSampleNote(context).then(
                  (note) => {
                    IntroSamples.getSampleDrawing(context).then((drawing) => {
                      AppNavigator.navigateToIntro(context, note, drawing)
                    })
                  })
            }
        });
  }

  Future<bool> _isTutorialDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(Constants.showTutorialSharedPrefKey) ?? false);
  }

  void _showSearch() {
    //TODO TBD
  }
}
