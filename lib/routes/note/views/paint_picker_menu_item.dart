import 'package:drawablenotepadflutter/routes/note/menu_items_controller.dart';
import 'package:flutter/material.dart';

import 'paint_picker.dart';

class PaintPickerMenuItem extends StatefulWidget {
  PaintPickerMenuItem({Key key, this.onPressed}) : super(key: key);

  final Function onPressed;

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
      icon: Icon(Icons.build, color: color),
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
          showBottomSheet(context: context, builder: (context) => PaintPicker());
      bottomSheetController.closed.then((value) => {bottomSheetOpen = false});
      bottomSheetOpen = true;
    });
  }

}
