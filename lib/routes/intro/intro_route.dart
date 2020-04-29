import 'package:drawablenotepadflutter/const.dart';
import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:drawablenotepadflutter/routes/list/views/note_item.dart';
import 'package:drawablenotepadflutter/routes/note/note_route.dart';
import 'package:drawablenotepadflutter/translations.dart';
import 'package:flutter/material.dart';
import 'package:drawablenotepadflutter/data/notepad_database.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({this.note});

  Note note;

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  var noteRoute;
  CurvedAnimation _animationModal;
  CurvedAnimation _animationLogoScale;
  AnimationController _animationModalController;
  AnimationController _animationLogoPositionController;
  AnimationController _animationLogoScaleController;
  bool modalVisible = false;
  bool logoAnimationFinished = false;
  bool animationFirstArrowFinished = false;
  bool animationFirstTextFinished = false;
  bool animationSecondArrowFinished = false;
  Animation<Offset> logoOffset;

  @override
  void initState() {
    noteRoute = NoteRoute(note: widget.note, previewMode: true);

    _animationModalController = AnimationController(
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.7,
        upperBound: 0.75,
        vsync: this);
    _animationModal = CurvedAnimation(
        parent: _animationModalController, curve: Curves.easeInOutQuad);

    _animationLogoPositionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    logoOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -1.0))
        .animate(_animationLogoPositionController.drive(
      CurveTween(curve: Curves.easeInQuart),
    ));

    _animationLogoScaleController = AnimationController(
        vsync: this,
        upperBound: 1.0,
        lowerBound: 0.4,
        duration: Duration(milliseconds: 500));
    _animationLogoScale = CurvedAnimation(
        parent: _animationLogoScaleController, curve: Curves.easeInOutQuad);

    WidgetsBinding.instance.addPostFrameCallback((_) => {
          _animationLogoPositionController.forward().then((value) => {
                setState(() {
                  logoAnimationFinished = true;
                })
              }),
          _animationLogoScaleController.reverse(from: 1.0)
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> notesItems = List();

    final int textAnimationDuration = 400;
    final int arrowsAnimationDuration = 200;

    notesItems.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedOpacity(
        opacity: animationFirstArrowFinished ? 1.0 : 0.0,
        duration: Duration(milliseconds: textAnimationDuration),
        onEnd: () => {
          setState(() {
            animationFirstTextFinished = true;
          })
        },
        child: Transform.rotate(
          angle: -0.1,
          child: Text(
            AppLocalizations.of(context)
                .translate('tutorialLongPressForPreview'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ));

    notesItems.add(Padding(
      padding: const EdgeInsets.all(24.0),
      child: AnimatedOpacity(
        opacity: logoAnimationFinished ? 1.0 : 0.0,
        duration: Duration(milliseconds: arrowsAnimationDuration),
        onEnd: () => {
          setState(() {
            animationFirstArrowFinished = true;
          })
        },
        child: Transform(
          transform: Matrix4.rotationY(3.14),
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: 1.0,
            child: Image(
              image: AssetImage("assets/arrow.png"),
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    ));

    notesItems.add(Container(
        color: Colors.white,
        child: NoteItem(
            note: widget.note,
            demoMode: true,
            onNotePreviewRequested: _previewNote)));

    notesItems.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(right: 24.0, top: 24),
          width: 200,
          child: AnimatedOpacity(
            opacity: animationSecondArrowFinished ? 1.0 : 0.0,
            duration: Duration(milliseconds: textAnimationDuration),
            child: Transform.rotate(
              angle: 0.1,
              child: Text(
                AppLocalizations.of(context)
                    .translate('tutorialSwipeToShareDelete'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: AnimatedOpacity(
              opacity: animationFirstTextFinished ? 1.0 : 0.0,
              duration: Duration(milliseconds: arrowsAnimationDuration),
              onEnd: () => {
                setState(() {
                  animationSecondArrowFinished = true;
                })
              },
              child: Transform.rotate(
                angle: -1.3,
                child: Image(
                  image: AssetImage("assets/arrow.png"),
                  width: 80,
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      ],
    ));

    return Container(
      color: Settings.defaultColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            opacity: logoAnimationFinished ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: Scaffold(
              appBar: null,
              backgroundColor: Settings.defaultColor,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Settings.defaultColor[100],
                child: new Icon(Icons.arrow_forward, size: 30.0),
                heroTag: null,
                onPressed: () => {AppNavigator.navigateToNoteList(context)},
              ),
              body: Container(
                  child: Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: notesItems,
                ),
              )),
            ),
          ),
          SlideTransition(
              position: logoOffset,
              child: ScaleTransition(
                scale: _animationLogoScale,
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/icon.png"),
                  fit: BoxFit.fill,
                  width: 170,
                  height: 200,
                ),
              )),
          IgnorePointer(
              ignoring: !modalVisible,
              child: AnimatedOpacity(
                opacity: modalVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Color.fromARGB(100, 0, 0, 0),
                    ),
                    if (noteRoute != null)
                      ScaleTransition(
                        scale: _animationModal,
                        alignment: Alignment.center,
                        child: noteRoute,
                      )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void _previewNote(Note note, bool show, bool share) {
    if (show) {
      modalVisible = true;
    } else {
      modalVisible = false;
    }
    setState(() {});
  }
}
