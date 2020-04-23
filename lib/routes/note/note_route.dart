import 'dart:async';
import 'dart:convert';

import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/note/views/font_picker_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quiver/strings.dart';

import '../../const.dart';
import 'menu_items_controller.dart';
import 'views/paint_picker_menu_item.dart';

class NoteRoute extends StatefulWidget {
  NoteRoute({Key key, this.note}) : super(key: key);

  Note note;

  @override
  _NoteRouteState createState() => _NoteRouteState();
}

class _NoteRouteState extends State<NoteRoute> {

  // Controllers
  ZefyrController _zefyrController;
  PainterController _painterController;
  DrawModeController _drawModeController;

  // For zefyr
  FocusNode _focusNode;

  Timer saveNoteTimer;

  // Keys
  final _fontPickerKey = GlobalKey<FontPickerMenuItemState>();
  final _paintPickerkey = GlobalKey<PaintPickerMenuItemState>();

  @override
  void initState() {
    super.initState();

    // Init zefyr
    final document = _loadDocument();
    _zefyrController = ZefyrController(document,
        onToolbarVisibilityChange: (visible) =>
            {_drawModeController.onFontPickerVisibilityChanged(visible)});
    _zefyrController.addListener(startSaveNoteTimer);
    _focusNode = FocusNode();

    // Init painter
    _painterController = _getPainterController();

    // Init mode controller
    _drawModeController = DrawModeController(
        fontPickerKey: _fontPickerKey,
        paintPickerkey: _paintPickerkey,
        onToolbarStateChanged: () => setState(() {}));
  }

  // TODO: Provide it via DI
  PainterController _getPainterController() {
    PainterController controller =
        new PainterController(widget.note != null ? widget.note.paths : null, compressionLevel: Settings.painterPathCompressionLevel);
    controller.thickness = 5.0;
    controller.drawColor = Settings.defaultColor.withAlpha(Settings.paintColorAlpha);
    controller.backgroundColor = Colors.transparent;
    controller.setOnDrawStepListener(startSaveNoteTimer);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    final double bottomPainterPadding = _drawModeController.bottomBarVisible()
        ? ZefyrToolbar.kToolbarHeight
        : 0.0;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Note"),
          actions: <Widget>[
            FontPickerMenuItem(
              key: _fontPickerKey,
              onPressed: _drawModeController.toggleFontPicker,
              focusNode: _focusNode,
            ),
            PaintPickerMenuItem(
                key: _paintPickerkey,
                painterController: _painterController,
                onPressed: _drawModeController.togglePaintPicker)
          ],
        ),
        body: Stack(
          children: [
            IgnorePointer(
              ignoring: _drawModeController.isDrawMode(),
              child: ZefyrScaffold(
                child: ZefyrEditor(
                  padding: EdgeInsets.all(16),
                  controller: _zefyrController,
                  focusNode: _focusNode,
                ),
              ),
            ),
            IgnorePointer(
              ignoring: _drawModeController.isTextMode(),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPainterPadding),
                child:
                    Opacity(opacity: 0.6, child: Painter(_painterController)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    saveNoteTimer?.cancel();
    return _saveNote(isPopping: true);
  }

  startSaveNoteTimer() {
    saveNoteTimer?.cancel();
    saveNoteTimer = new Timer(Duration(milliseconds: Settings.saveNoteTimerDurationMillis), () => {
      _saveNote()
    });
  }

  Future<bool> _saveNote({isPopping = false}) async {
    if (_drawModeController.isDrawMode() && isPopping) return true;

    /// Loads the document to be edited in Zefyr.
    final database = Provider.of<NotepadDatabase>(context, listen: false);

    String paintHistory = _painterController.history;

    if (isNotBlank(_zefyrController.document.toPlainText()) || paintHistory.length >= 3) {
      final noteText = jsonEncode(_zefyrController.document);
      if (widget.note != null) {
        if (widget.note.noteText != noteText || widget.note.paths != paintHistory) {
          var newNote = widget.note
              .copyWith(noteText: noteText, paths: paintHistory == null ? "[]" : paintHistory);
          database.updateNote(newNote);
          widget.note = newNote;
        }
      } else {
        var newNote = Note(
            noteText: noteText,
            noteDate: new DateTime.now(),
            paths: paintHistory);
        var noteId = await database.insertNote(newNote);
        widget.note = newNote.copyWith(id: noteId);
      }
    } else {
      if (widget.note != null && isPopping) {
        database.deleteNote(widget.note);
      }
    }
    return true;
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    if (widget.note != null) {
      return NotusDocument.fromJson(json.decode(widget.note.noteText) as List);
    } else {
      return NotusDocument();
    }
  }
}
