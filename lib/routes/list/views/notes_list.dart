import 'dart:convert';

import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/list/views/note_item.dart';
import 'package:drawablenotepadflutter/routes/note/note_route.dart';
import 'package:drawablenotepadflutter/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'dart:ui' as ui;

import '../../../const.dart';

class NotesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NotesListState();
  }
}

class NotesListState extends State<NotesList> with TickerProviderStateMixin {
  bool modalVisible = false;
  bool shareMode = false;
  bool screenShootEffectVisibile = false;
  Note visibleNote;

  var currentNoteRoute;
  AnimationController _animationController;
  CurvedAnimation _animation;

  GlobalKey _repaintKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildNotesList(),
        IgnorePointer(
            ignoring: !modalVisible,
            child: AnimatedOpacity(
              onEnd: () => {
                if (!modalVisible)
                  {
                    setState(() => {currentNoteRoute = null})
                  }
                else
                  {
                    setState(() => {
                          if (shareMode) {screenShootEffectVisibile = true}
                        })
                  }
              },
              opacity: modalVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Color.fromARGB(100, 0, 0, 0),
                  ),
                  if (currentNoteRoute != null)
                    ScaleTransition(
                      scale: _animation,
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          RepaintBoundary(
                            key: _repaintKey,
                            child: currentNoteRoute,
                          ),
                          AnimatedOpacity(
                            opacity: screenShootEffectVisibile ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 100),
                            onEnd: () => {
                              if (screenShootEffectVisibile)
                                {
                                  setState(
                                      () => {screenShootEffectVisibile = false})
                                }
                              else
                                {_shareNote()}
                            },
                            child: Container(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            )),
      ],
    );
  }

  StreamBuilder<List<Note>> _buildNotesList() {
    final database = Provider.of<NotepadDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllNotes(),
      builder: (context, AsyncSnapshot snapshot) {
        final notes = snapshot.data ?? List();


        if (notes.length > 0) {
          return ListView.separated(
              itemBuilder: (_, index) {
                final itemNote = notes[snapshot.data.length -
                    index -
                    1]; //TODO Ugly workaroud for reversing list order, IDK how to make that on Moor level
                return NoteItem(
                  key: ObjectKey(itemNote),
                  note: itemNote,
                  onNotePreviewRequested: (note, show, share) => {
                    if (show)
                      {_showModal(note, share)}
                    else
                      {_cancelModal(false)}
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(
                    color: Settings.noteItemSeparatorColor,
                    height: 0.0,
                  ),
              itemCount: notes.length);
        } else {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 100),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.rotate(
                      angle: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(AppLocalizations.of(context).translate('tutorialClickHereToAddNewNote'), style: TextStyle(
                            fontSize: 20
                        ),),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 80, bottom: 40),
                            child: Container(
                              width: 130,
                              height: 100,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image(
                                  image: AssetImage("assets/arrow.png"),
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        }
      },
    );
  }

  refreshAnimation() {
    _animationController?.dispose();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.7,
        upperBound: 0.75,
        vsync: this);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutQuad);
  }

  _showModal(Note note, bool share) {
    setState(() {
      refreshAnimation();
      shareMode = share;
      currentNoteRoute = NoteRoute(note: note, previewMode: true);
      modalVisible = true;
      _animationController.forward();
    });
  }

  _cancelModal(bool screenShootAnimate) {
    setState(() {
      shareMode = false;
      modalVisible = false;
      _animationController.reverse();
    });
  }

  Future<void> _shareNote() async {
    try {
      RenderRepaintBoundary boundary =
          _repaintKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      await Share.file('Note', 'note.png', pngBytes, 'image/png',
          text: AppLocalizations.of(context).translate('shareNoteText'));
    } catch (e) {
      print(e);
    }
    _cancelModal(true);
  }
}
