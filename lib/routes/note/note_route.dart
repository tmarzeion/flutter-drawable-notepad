import 'dart:typed_data';
import 'dart:convert';

import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/note/views/font_picker_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quiver/strings.dart';

import 'menu_items_controller.dart';
import 'views/paint_picker_menu_item.dart';

class NoteRoute extends StatefulWidget {
  NoteRoute({Key key, this.note}) : super(key: key);

  Note note;

  @override
  _NoteRouteState createState() => _NoteRouteState();
}

class _NoteRouteState extends State<NoteRoute> {
  /// Allows to control the editor and the document.
  ZefyrController _zefyrController; //TODO bar visibility listener
  PainterController _painterController;
  DrawModeController _drawModeController;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  final _fontPickerKey = GlobalKey<FontPickerMenuItemState>();
  final _paintPickerkey = GlobalKey<PaintPickerMenuItemState>();

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _zefyrController = ZefyrController(document,
        onToolbarVisibilityChange: (visible) =>
            {_drawModeController.onFontPickerVisibilityChanged(visible)});
    _painterController = _getPainterController();
    _drawModeController = DrawModeController(
        fontPickerKey: _fontPickerKey,
        paintPickerkey: _paintPickerkey,
        onToolbarStateChanged: () => setState(() => print(''))); //TODO ?
    _focusNode = FocusNode();
  }

  // TODO: Provide it via DI
  PainterController _getPainterController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.drawColor = Colors.amber
        .withAlpha(220); //TODO Use default colors list from paintpicker
    controller.backgroundColor = Colors.transparent;
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
    /// Loads the document to be edited in Zefyr.
    final database = Provider.of<NotepadDatabase>(context, listen: false);
    if (isNotBlank(_zefyrController.document.toPlainText())) {
      final noteText = jsonEncode(_zefyrController.document);
      if (widget.note != null) {
        if (widget.note.noteText != noteText) {
          database.updateNote(widget.note.copyWith(noteText: noteText));
        }
      } else {
        database.insertNote(Note(
            noteText: noteText,
            noteDate: new DateTime.now(),
            bitmap: await _painterController.finish().toPNG()));
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
