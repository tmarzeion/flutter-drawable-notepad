import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';

const alpha = 220;

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
  void changeColorAndDismissDialog(Color color) {
    setState(() {
      widget.painterController.drawColor = color;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 224, 224, 224),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _createColorPickerButton(),
          ],
        ),
      ),
      height: 50,
    );
  }

  Widget _createColorPickerButton() {
    return IconButton(
        icon: Icon(Icons.color_lens),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: widget.painterController.drawColor,
                    onColorChanged: changeColorAndDismissDialog,
                    availableColors: _defaultColors,
                  ),
                ),
              );
            },
          );
        });
  }
}

class MenuItem {
  const MenuItem({this.title, this.icon});

  final String title;
  final IconData icon;
}
