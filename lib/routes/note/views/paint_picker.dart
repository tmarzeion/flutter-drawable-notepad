import 'dart:io';

import 'package:drawablenotepadflutter/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:painter/painter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const alpha = 220;
const bottomBarHeight = 50.0;
const undoDisabledColor = Colors.black26;

class DrawThicknessMode {
  DrawThicknessMode(this.thickness, this.vectorAssetPath);

  double thickness;
  double vectorPadding;
  String vectorAssetPath;
}

const defaultThicknessMode = 2;
List<DrawThicknessMode> _drawThicknessModes = [
  DrawThicknessMode(2.0, "assets/1.svg"),
  DrawThicknessMode(5.0, "assets/2.svg"),
  DrawThicknessMode(10.0, "assets/3.svg"),
  DrawThicknessMode(14.0, "assets/4.svg"),
  DrawThicknessMode(18.0, "assets/5.svg"),
];

List<Color> _defaultColors = [
  Colors.red.withAlpha(alpha),
  Colors.pink.withAlpha(alpha),
  Colors.purple.withAlpha(alpha),
  Colors.deepPurple.withAlpha(alpha),
  Colors.indigo.withAlpha(alpha),
  Colors.blue.withAlpha(alpha),
  Colors.lightBlue.withAlpha(alpha),
  Colors.cyan.withAlpha(alpha),
  Colors.teal.withAlpha(alpha),
  Colors.green.withAlpha(alpha),
  Colors.lightGreen.withAlpha(alpha),
  Colors.lime.withAlpha(alpha),
  Colors.yellow.withAlpha(alpha),
  Colors.amber.withAlpha(alpha),
  Colors.orange.withAlpha(alpha),
  Colors.deepOrange.withAlpha(alpha),
  Colors.brown.withAlpha(alpha),
  Colors.grey.withAlpha(alpha),
  Colors.blueGrey.withAlpha(alpha),
  Colors.black.withAlpha(alpha),
];

class PaintPicker extends StatefulWidget {
  PaintPicker(this.painterController, {Key key}) : super(key: key);

  PainterController painterController;

  @override
  _PaintPickerState createState() => _PaintPickerState();
}

class _PaintPickerState extends State<PaintPicker> {
  int currentThicknessMode = defaultThicknessMode;

  void changeColorAndDismissDialog(Color color) {
    setState(() {
      widget.painterController.drawColor = color;
      widget.painterController.eraseMode = false;
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.painterController.setOnDrawStepListener(_refreshHistoryState);
  }

  @override
  Widget build(BuildContext context) {
    widget.painterController.thickness =
        _drawThicknessModes[currentThicknessMode].thickness;
    return Container(
      color: Color.fromARGB(255, 224, 224, 224),
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
      height: bottomBarHeight,
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
          width: 50,
          height: 50,
          padding: EdgeInsets.all(12.5),
          child: SvgPicture.asset(
            "assets/undo-alt.svg",
            color: hasHistory ? Colors.black : undoDisabledColor,
          )),
      onPressed: hasHistory ? _undoPaintStep : null,
    );
  }

  _createEraserButton() {
    return FlatButton(
      color: widget.painterController.eraseMode
          ? Colors.amber.withAlpha(150)
          : null,
      child: Container(
          width: 50,
          height: 50,
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
          width: 50,
          height: 50,
          padding: EdgeInsets.all(8),
          child: SvgPicture.asset(
              _drawThicknessModes[currentThicknessMode].vectorAssetPath)),
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
            availableColors: _defaultColors,
            layoutBuilder: _getColorPickerLayoutBuilder,
            itemBuilder: _getColorPickerItemBuilder,
          ),
        );
      },
    );
  }

  void _undoPaintStep() {
    widget.painterController.undo();
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
          title: Text("Are you sure?"),
          content:
          Text("Long pressing erase button will clear the whole drawing"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Erase', style: TextStyle(
                color: Color.fromARGB(255, 255, 59, 48)
              ),),
              onPressed: () async {
                _clear();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Cancel'),
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
          title: Text("Are you sure?"),
          content:
          Text("Long pressing erase button will clear the whole drawing"),
          actions: <Widget>[
            FlatButton(
              child: Text('Erase'.toUpperCase()),
              onPressed: () async {
                _clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancel'.toUpperCase()),
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
    setState(() {});
  }

  void _changeThickness() {
    currentThicknessMode++;
    setState(() {
      currentThicknessMode = currentThicknessMode % _drawThicknessModes.length;
      print('MODE $currentThicknessMode');
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
      width: 50,
      height: 50,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
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
          borderRadius: BorderRadius.circular(50.0),
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

class MenuItem {
  const MenuItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

/* alternate color picker icon
  Widget _createColorPickerButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
          child: new PhysicalModel(
            color: widget.painterController.drawColor,
            borderRadius: new BorderRadius.circular(25.0),
            child: Stack(children: <Widget>[
              new Container(
                width: 25.0,
                height: 25.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(12.5),
                  border: new Border.all(
                    width: 3.0,
                    color: Color.fromARGB(255, 224, 224, 224),
                  ),
                ),
              ),
              new Container(
                width: 25.0,
                height: 25.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(12.5),
                  border: new Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                ),
              )
            ]),
          ),
          padding: EdgeInsets.all(12.5)),
      onTap: _showPicker,
    );

    return IconButton(icon: Icon(Icons.color_lens), onPressed: _showPicker);
  }

*/
