import 'package:flutter/material.dart';

import '../menu_items_controller.dart';

class FontPickerMenuItem extends StatefulWidget {

  FontPickerMenuItem({Key key, this.onPressed, this.focusNode, this.openOnStart}) : super(key: key);

  final bool openOnStart;
  final FocusNode focusNode;
  final Function onPressed;

  @override
  State createState() => FontPickerMenuItemState();
}

class FontPickerMenuItemState extends State<FontPickerMenuItem> implements Closeable {

  bool isOpen;

  @override
  void initState() {
    isOpen = widget.openOnStart;
  }

  @override
  Widget build(BuildContext context) {
    var color = isOpen ? Colors.white : Colors.black; // TODO better design later
    if (!isOpen) close();
    return IconButton(
      icon: Icon(Icons.text_fields, color: color),
      onPressed: () {
        setState(widget.onPressed);
      },
    );
  }

  @override
  void close() {
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  @override
  bool getState() {
    return isOpen;
  }

  @override
  void open() {
    setState(widget.focusNode.requestFocus);
  }

}
