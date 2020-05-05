import 'package:drawablenotepadflutter/routes/note/views/font_picker_menu_item.dart';
import 'package:drawablenotepadflutter/routes/note/views/paint_picker_menu_item.dart';
import 'package:flutter/widgets.dart';

class DrawModeController {

  DrawModeController({this.fontPickerKey, this.paintPickerKey, this.onToolbarStateChanged});

  GlobalKey<FontPickerMenuItemState> fontPickerKey;
  GlobalKey<PaintPickerMenuItemState> paintPickerKey;
  Function onToolbarStateChanged;

  bool bottomBarVisible() {
    if(fontPickerKey.currentState?.getState() != null && paintPickerKey.currentState?.getState() != null) {
      return fontPickerKey.currentState.getState() || paintPickerKey.currentState.getState();
    }
    return false;
  }

  bool isDrawMode() {
    if (paintPickerKey.currentState?.getState() != null) {
      return paintPickerKey.currentState.getState();
    }
    return false;
  }

  bool isTextMode() {
    if (paintPickerKey.currentState?.getState() != null) {
      return !paintPickerKey.currentState.getState();
    }
    return true;
  }

  onFontPickerVisibilityChanged(bool visible) {
    fontPickerKey.currentState.isOpen = visible;
    onToolbarStateChanged?.call();
    if (visible) {
      hidePaintPicker();
    }
  }

  hideFontPicker() {
    fontPickerKey.currentState.close();
  }

  hidePaintPicker() {
    paintPickerKey.currentState.close();
  }

  openPaintPicker() {
    paintPickerKey?.currentState?.open();
  }

  openFontPicker() {
    fontPickerKey?.currentState?.open();
  }

  toggleFontPicker() {
    hidePaintPicker();
    _toggleCloseable(fontPickerKey.currentState);
  }

  togglePaintPicker() {
    hideFontPicker();
    _toggleCloseable(paintPickerKey.currentState);
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
