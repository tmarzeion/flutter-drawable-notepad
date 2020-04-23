import 'package:drawablenotepadflutter/routes/note/menu_items_controller.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

import 'paint_picker.dart';

class PaintPickerMenuItem extends StatefulWidget {
  PaintPickerMenuItem({Key key, this.onPressed, this.painterController, this.onUpdateNoteSettingsListener}) : super(key: key);

  final Function onPressed;
  final PainterController painterController;
  final Function onUpdateNoteSettingsListener;

  @override
  State createState() => PaintPickerMenuItemState();
}

class PaintPickerMenuItemState extends State<PaintPickerMenuItem>
    implements Closeable {
  bool bottomSheetOpen = false;
  PersistentBottomSheetController bottomSheetController;

  @override
  Widget build(BuildContext context) {
    var color = bottomSheetOpen ? Colors.white : Colors.black; // TODO better design later
    return IconButton(
      icon: Icon(Icons.brush, color: color),
      onPressed: () {
        setState(widget.onPressed);
      },
    );
  }

  @override
  void close() {
    setState(bottomSheetController?.close);
  }

  @override
  bool getState() {
    return bottomSheetOpen;
  }

  @override
  void open() {
    setState(() {
      bottomSheetController =
          showBottomSheet(context: context, builder: (context) => PaintPicker(widget.painterController, onUpdateNoteSettingsListener: widget.onUpdateNoteSettingsListener,));
      bottomSheetController.closed.then((value) => {bottomSheetOpen = false});
      bottomSheetOpen = true;
    });
  }

}
