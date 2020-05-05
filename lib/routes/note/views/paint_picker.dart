import 'dart:io';

import 'package:drawablenotepadflutter/const.dart';
import 'package:drawablenotepadflutter/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:painter/painter.dart';

class PaintPicker extends StatefulWidget {
  PaintPicker(this.painterController,
      {Key key, this.onUpdateNoteSettingsListener})
      : super(key: key);

  final Function onUpdateNoteSettingsListener;
  final PainterController painterController;

  @override
  _PaintPickerState createState() => _PaintPickerState();
}

class _PaintPickerState extends State<PaintPicker> {
  int currentThicknessMode;

  void changeColorAndDismissDialog(Color color) {
    setState(() {
      widget.painterController.drawColor = color;
      widget.painterController.eraseMode = false;
      widget?.onUpdateNoteSettingsListener?.call();
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    currentThicknessMode = Settings.drawThicknessModes.indexWhere(
        (element) => element.thickness == widget.painterController.thickness);
    widget.painterController.setOnHistoryUpdatedListener(_refreshHistoryState);
  }

  @override
  Widget build(BuildContext context) {
    widget.painterController.thickness =
        Settings.drawThicknessModes[currentThicknessMode].thickness;
    return Container(
      color: Settings.bottomBarBackgroundColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _createUndoButton(),
            _createEraserButton(),
            _createThicknessPickerButton(),
            _createColorPickerButton(),
          ],
        ),
      ),
      height: Settings.bottomBarHeight,
    );
  }

  Widget _createColorPickerButton() {
    return FlatButton(
      child: Container(
          child: new PhysicalModel(
            color: widget.painterController.eraseMode
                ? Colors.white
                : widget.painterController.drawColor,
            borderRadius: new BorderRadius.circular(25.0),
            child: new Container(
              width: 25.0,
              height: 25.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(12.5),
                border: new Border.all(
                  width: 3.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          padding: EdgeInsets.all(12.5)),
      onPressed: _showPicker,
    );
  }

  _createUndoButton() {
    bool hasHistory = widget.painterController.hasHistory();
    return FlatButton(
      child: Container(
          width: Settings.bottomBarHeight,
          height: Settings.bottomBarHeight,
          padding: EdgeInsets.all(12.5),
          child: SvgPicture.asset(
            "assets/undo-alt.svg",
            color: hasHistory ? Colors.black : Settings.undoDisabledColor,
          )),
      onPressed: hasHistory ? _undoPaintStep : null,
    );
  }

  _createEraserButton() {
    return FlatButton(
      color: widget.painterController.eraseMode
          ? Settings.activeEraserBackground
          : null,
      child: Container(
          width: Settings.bottomBarHeight,
          height: Settings.bottomBarHeight,
          padding: EdgeInsets.all(12.5),
          child: SvgPicture.asset("assets/eraser.svg")),
      onPressed: _toggleEraseMode,
      onLongPress: _clearWithAlert,
    );
  }

  _createThicknessPickerButton() {
    return FlatButton(
      onPressed: _changeThickness,
      child: Container(
          width: Settings.bottomBarHeight,
          height: Settings.bottomBarHeight,
          padding: EdgeInsets.all(8),
          child: SvgPicture.asset(Settings
              .drawThicknessModes[currentThicknessMode].vectorAssetPath)),
    );
  }

  void _showPicker() {
    setState(() {
      widget.painterController.eraseMode = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: BlockPicker(
            pickerColor: widget.painterController.drawColor,
            onColorChanged: changeColorAndDismissDialog,
            availableColors: Settings.paintColors,
            layoutBuilder: _getColorPickerLayoutBuilder,
            itemBuilder: _getColorPickerItemBuilder,
          ),
        );
      },
    );
  }

  void _undoPaintStep() {
    widget.painterController.undo();
    widget?.onUpdateNoteSettingsListener?.call();
    _refreshHistoryState();
  }

  void _toggleEraseMode() {
    widget.painterController.eraseMode = !widget.painterController.eraseMode;
    setState(() {});
  }

  void _clearWithAlert() async {
    if (Platform.isAndroid) {
      showMaterialEraseAlertDialog();
    } else if (Platform.isIOS) {
      showCupertinoEraseAlertDialog();
    }
  }

  void showCupertinoEraseAlertDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context).translate('eraseAlertTitle')),
          content: Text(AppLocalizations.of(context).translate('eraseAlertContent')),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                AppLocalizations.of(context).translate('eraseAlertYes'),
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 59, 48) // iOS Red color
                    ),
              ),
              onPressed: () async {
                _clear();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(AppLocalizations.of(context).translate('eraseAlertNo')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showMaterialEraseAlertDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('eraseAlertTitle')),
          content: Text(AppLocalizations.of(context).translate('eraseAlertContent')),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('eraseAlertYes').toUpperCase()),
              onPressed: () async {
                _clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('eraseAlertNo').toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _clear() {
    widget.painterController.clear();
    widget.painterController.eraseMode = false;
    widget?.onUpdateNoteSettingsListener?.call();
    setState(() {});
  }

  void _changeThickness() {
    currentThicknessMode++;
    widget?.onUpdateNoteSettingsListener?.call();
    setState(() {
      currentThicknessMode =
          currentThicknessMode % Settings.drawThicknessModes.length;
    });
  }

  void _refreshHistoryState() {
    setState(() {});
  }

  static Widget _getColorPickerLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  static Widget _getColorPickerItemBuilder(
      Color color, bool isCurrentColor, Function changeColor) {
    return Container(
      width: Settings.colorCircleItemSize,
      height: Settings.colorCircleItemSize,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Settings.colorCircleItemSize),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            offset: Offset(1.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(Settings.colorCircleItemSize),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class DrawThicknessMode {
  DrawThicknessMode(this.thickness, this.vectorAssetPath);
  double thickness;
  double vectorPadding;
  String vectorAssetPath;
}
