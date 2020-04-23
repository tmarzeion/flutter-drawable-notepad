import 'package:drawablenotepadflutter/routes/note/menu_items_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:painter/painter.dart';

class PaintPickerMenuItem extends StatefulWidget {
  PaintPickerMenuItem(
      {Key key,
      this.onPressed,
      this.painterController,
      this.openOnStart,
      this.bottomBarWidget})
      : super(key: key);

  final Function onPressed;
  final PainterController painterController;
  final bool openOnStart;
  final Widget bottomBarWidget;

  @override
  State createState() => PaintPickerMenuItemState();
}

class PaintPickerMenuItemState extends State<PaintPickerMenuItem>
    implements Closeable {
  bool initialized = false;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    var color =
        isOpen ? Colors.white : Colors.black; // TODO better design later
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
      SchedulerBinding.instance.addPostFrameCallback((_) => open());
    }
    initialized = true;
  }

  @override
  void close() {
    setState(() => {isOpen = false});
  }

  @override
  bool getState() {
    return isOpen;
  }

  @override
  void open() {
    setState(() {
      isOpen = true;
    });
  }
}
