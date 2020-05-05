import 'dart:async';
import 'dart:convert';

import 'package:drawablenotepadflutter/data/NoteSettingsConverter.dart';
import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/note/views/font_picker_menu_item.dart';
import 'package:drawablenotepadflutter/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:painter/painter.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quiver/strings.dart';

import '../../const.dart';
import 'menu_items_controller.dart';
import 'views/paint_picker.dart';
import 'views/paint_picker_menu_item.dart';

class NoteRoute extends StatefulWidget {
  NoteRoute({Key key, this.note, this.previewMode}) : super(key: key);

  Note note;
  bool previewMode = false;

  @override
  _NoteRouteState createState() => _NoteRouteState();
}

class _NoteRouteState extends State<NoteRoute>
    with SingleTickerProviderStateMixin {
  // Controllers
  ZefyrController _zefyrController;
  PainterController _painterController;
  DrawModeController _drawModeController;
  ScrollController _scrollControllerForText = new ScrollController();
  ScrollController _scrollControllerForPainter = new ScrollController();

  AnimationController _keyboardAnimationController;
  Animation _animation;

  NotepadDatabase database;

  // For zefyr
  FocusNode _focusNode;
  ZefyrScaffold _zefyr;

  Timer saveNoteTimer;

  bool initialized = false;

  // Keys
  final _fontPickerMenuKey = GlobalKey<FontPickerMenuItemState>();
  final _paintPickerMenuKey = GlobalKey<PaintPickerMenuItemState>();

  @override
  void initState() {
    super.initState();

    database = Provider.of<NotepadDatabase>(context, listen: false);

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
        fontPickerKey: _fontPickerMenuKey,
        paintPickerKey: _paintPickerMenuKey,
        onToolbarStateChanged: () => setState(() {
              startSaveNoteTimer();
            }));

    _keyboardAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _keyboardAnimationController.forward();
      } else {
        _keyboardAnimationController.reverse();
      }
    });

    _scrollControllerForText.addListener(() {
      _scrollControllerForPainter.jumpTo(_scrollControllerForText.offset);
    });

    scaffoldZefyr();
  }

  // TODO: Provide it via DI
  PainterController _getPainterController() {
    PainterController controller = new PainterController(
        widget.note != null ? widget.note.paths : null,
        compressionLevel: Settings.painterPathCompressionLevel);
    if (widget.note != null) {
      NoteSettings settings = NoteSettingsConverter.fromNote(widget.note);
      controller.thickness = settings.paintThickness;
      controller.drawColor = Color.fromARGB(Settings.paintColorAlpha,
          settings.paintR, settings.paintG, settings.paintB);
    } else {
      controller.thickness =
          Settings.drawThicknessModes[Settings.defaultThicknessMode].thickness;
      controller.drawColor =
          Settings.defaultColor.withAlpha(Settings.paintColorAlpha);
    }
    controller.backgroundColor = Colors.transparent;
    controller.setOnDrawStepListener(startSaveNoteTimer);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (_animation == null) {
      if (keyboardHeight > 0) {
        _animation = Tween(begin: 0.0, end: keyboardHeight)
            .animate(_keyboardAnimationController)
              ..addListener(() {
                setState(() {});
              });
      }
    } else {
      if (keyboardHeight == 0 &&
          _animation.value > 0 &&
          _animation.isCompleted) {
        _drawModeController.hideFontPicker();
      }
    }

    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    bool shouldIgnoreTextEditorClicks = _drawModeController.isDrawMode();
    bool shouldIgnorePainterClicks = _drawModeController.isTextMode();

    if (!initialized) {
      if (widget.note != null) {
        var initialDrawModeOn =
            NoteSettingsConverter.fromNote(widget.note).drawMode;
        shouldIgnoreTextEditorClicks = initialDrawModeOn;
        shouldIgnorePainterClicks = !initialDrawModeOn;
      }
    }
    final double bottomPainterPadding = _drawModeController.bottomBarVisible()
        ? ZefyrToolbar.kToolbarHeight
        : 0.0;

    final menuItems = <Widget>[
      FontPickerMenuItem(
        previewMode: widget.previewMode,
        key: _fontPickerMenuKey,
        onPressed: _drawModeController.toggleFontPicker,
        focusNode: _focusNode,
        openOnStart: widget.note != null || widget.previewMode ? false : true,
      ),
      PaintPickerMenuItem(
          previewMode: widget.previewMode,
          key: _paintPickerMenuKey,
          painterController: _painterController,
          onPressed: _drawModeController.togglePaintPicker,
          openOnStart: widget.note != null
              ? NoteSettingsConverter.fromNote(widget.note).drawMode
              : false)
    ];

    final view = WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomPadding: false, // this avoids the overflow error
        appBar: widget.previewMode
            ? null
            : AppBar(
                title: Text(AppLocalizations.of(context)
                    .translate('noteRouteToolbarTitle')),
                actions: menuItems,
              ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  // Ugly hack to prevent keyboard from showing on preview mode«
                  if (widget.previewMode)
                    Opacity(opacity: 0, child: menuItems[0]),
                  if (widget.previewMode)
                    Opacity(opacity: 0, child: menuItems[1]),
                  IgnorePointer(
                    ignoring:
                    shouldIgnoreTextEditorClicks || widget.previewMode,
                    child: _drawModeController.bottomBarVisible() && !_drawModeController.isDrawMode() ? scaffoldZefyr() : _zefyr,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: bottomPainterPadding),
                    child: IgnorePointer(
                      ignoring:
                      shouldIgnorePainterClicks || widget.previewMode,
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _scrollControllerForPainter,
                        child: Container(
                          height: 1920,
                          child: Opacity(
                              opacity: 0.6,
                              child: Painter(_painterController)),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                    shouldIgnoreTextEditorClicks && !widget.previewMode,
                    child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                          height: Settings.bottomBarHeight,
                          child: PaintPicker(_painterController,
                              onUpdateNoteSettingsListener:
                              startSaveNoteTimer)),
                    ),
                  )
                ],
              ),
            ),
            Container(color: Colors.transparent, height: _animation?.value ?? 0)
          ],
        ),
      ),
    );
    initialized = true;
    return view;
  }

  ZefyrScaffold scaffoldZefyr() {
    _zefyr = ZefyrScaffold(
      child: ZefyrEditor(
        scrollController: _scrollControllerForText,
        padding: EdgeInsets.all(16),
        controller: _zefyrController,
        focusNode: _focusNode,
      ),
    );
    return _zefyr;
  }

  Future<bool> _onWillPop() async {
    saveNoteTimer?.cancel();
    return _saveNote(isPopping: true);
  }

  startSaveNoteTimer() {
    saveNoteTimer?.cancel();
    saveNoteTimer = new Timer(
        Duration(milliseconds: Settings.saveNoteTimerDurationMillis),
        () => {_saveNote()});
  }

  Future<bool> _saveNote({isPopping = false}) async {

    String paintHistory = _painterController.history;
    String noteSettings = _getCurrentNoteSettings();

    if (isNotBlank(_zefyrController.document.toPlainText()) ||
        paintHistory.length >= 3) {
      final noteText = jsonEncode(_zefyrController.document);
      if (widget.note != null) {
        if (widget.note.noteText != noteText ||
            widget.note.paths != paintHistory ||
            widget.note.noteSettings != noteSettings) {
          var newNote = widget.note.copyWith(
              noteText: noteText,
              notePlainText: _zefyrController.document.toPlainText(),
              paths: paintHistory == null ? "[]" : paintHistory,
              noteSettings: noteSettings);
          database.updateNote(newNote);
          widget.note = newNote;
        }
      } else {
        var newNote = Note(
            noteText: noteText,
            notePlainText: _zefyrController.document.toPlainText(),
            noteDate: new DateTime.now(),
            noteSettings: noteSettings,
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

  String _getCurrentNoteSettings() {
    return json.encode(NoteSettings(
        _drawModeController.isDrawMode(),
        _painterController.drawColor.red,
        _painterController.drawColor.green,
        _painterController.drawColor.blue,
        _painterController.thickness));
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
