import 'package:drawablenotepadflutter/routes/note/menu_items_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:painter/painter.dart';

import 'paint_picker.dart';

class PaintPickerMenuItem extends StatefulWidget {
  PaintPickerMenuItem({Key key, this.onPressed, this.painterController, this.onUpdateNoteSettingsListener, this.openOnStart}) : super(key: key);

  final Function onPressed;
  final PainterController painterController;
  final Function onUpdateNoteSettingsListener;
  final bool openOnStart;

  @override
  State createState() => PaintPickerMenuItemState();
}

class PaintPickerMenuItemState extends State<PaintPickerMenuItem>
    implements Closeable {
  bool initialized = false;
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

  void initState() {
    super.initState();
    if (widget.openOnStart && !initialized) {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => open());
    }
    initialized = true;
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
