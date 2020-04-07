import 'package:flutter/material.dart';

import 'font_picker.dart';

class FontPickerMenuItem extends StatefulWidget {
  @override
  State createState() => _FontPickerMenuItemState();
}

class _FontPickerMenuItemState extends State<FontPickerMenuItem> {
  bool fontPickerOpen = false;
  PersistentBottomSheetController bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.build),
      onPressed: () {
        if (fontPickerOpen) {
          bottomSheetController?.close();
        } else {
          bottomSheetController = showBottomSheet(
              context: context, builder: (context) => FontPicker());
          bottomSheetController.closed
              .then((value) => {fontPickerOpen = false});
          fontPickerOpen = true;
        }
      },
    );
  }
}
