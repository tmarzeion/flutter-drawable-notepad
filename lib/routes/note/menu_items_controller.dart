import 'package:drawablenotepadflutter/routes/note/views/font_picker_menu_item.dart';
import 'package:drawablenotepadflutter/routes/note/views/paint_picker_menu_item.dart';
import 'package:flutter/widgets.dart';

class DrawModeController {

  DrawModeController({this.fontPickerKey, this.paintPickerkey, this.onToolbarStateChanged});

  GlobalKey<FontPickerMenuItemState> fontPickerKey;
  GlobalKey<PaintPickerMenuItemState> paintPickerkey;
  Function onToolbarStateChanged;

  bool bottomBarVisible() {
    if(fontPickerKey.currentState?.getState() != null && paintPickerkey.currentState?.getState() != null) {
      return fontPickerKey.currentState.getState() || paintPickerkey.currentState.getState();
    }
    return false;
  }

  bool isDrawMode() {
    if (paintPickerkey.currentState?.getState() != null) {
      return paintPickerkey.currentState.getState();
    }
    return false;
  }

  bool isTextMode() {
    if (paintPickerkey.currentState?.getState() != null) {
      return !paintPickerkey.currentState.getState();
    }
    return true;
  }

  onFontPickerVisibilityChanged(bool visible) {
    fontPickerKey.currentState.isOpen = visible;
    onToolbarStateChanged?.call();
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
    onToolbarStateChanged?.call();
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
