import 'package:drawablenotepadflutter/routes/note/views/font_picker_menu_item.dart';
import 'package:drawablenotepadflutter/routes/note/views/paint_picker_menu_item.dart';
import 'package:flutter/widgets.dart';

class MenuItemsController {

  MenuItemsController({this.fontPickerKey, this. paintPickerkey});

  GlobalKey<FontPickerMenuItemState> fontPickerKey;
  GlobalKey<PaintPickerMenuItemState> paintPickerkey;

  void hideAll() {
    fontPickerKey.currentState.close();
    paintPickerkey.currentState.close();
  }

  onFontPickerVisibilityChanged(bool visible) {
    fontPickerKey.currentState.isOpen = visible;
    if (visible) {
      _hidePaintPicker();
    }
  }

  _hideFontPicker() {
    fontPickerKey.currentState.close();
  }

  _hidePaintPicker() {
    paintPickerkey.currentState.close();
  }

  toggleFontPicker() {
    _toggleCloseable(fontPickerKey.currentState);
    _hidePaintPicker();
  }

  togglePaintPicker() {
    _toggleCloseable(paintPickerkey.currentState);
    _hideFontPicker();
  }

  // Return new visibility state bool
  _toggleCloseable(Closeable closeable) {
    if (closeable.getState()) {
      closeable.close();
    } else {
      closeable.open();
    }
  }

}

abstract class Closeable {
  void close();
  void open();
  bool getState();
}
