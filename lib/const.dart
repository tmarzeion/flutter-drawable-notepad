import 'dart:ui';

import 'package:drawablenotepadflutter/routes/note/views/paint_picker.dart';
import 'package:flutter/material.dart';

class Constants {
  static final showClearAlertSharedPrefKey = 'showClearAlert';
}

class Settings {

  static List<DrawThicknessMode> drawThicknessModes = [
    DrawThicknessMode(2.0, "assets/1.svg"),
    DrawThicknessMode(5.0, "assets/2.svg"),
    DrawThicknessMode(10.0, "assets/3.svg"),
    DrawThicknessMode(14.0, "assets/4.svg"),
    DrawThicknessMode(18.0, "assets/5.svg"),
  ];

  static List<Color> paintColors = [
    Colors.red.withAlpha(paintColorAlpha),
    Colors.pink.withAlpha(paintColorAlpha),
    Colors.purple.withAlpha(paintColorAlpha),
    Colors.deepPurple.withAlpha(paintColorAlpha),
    Colors.indigo.withAlpha(paintColorAlpha),
    Colors.blue.withAlpha(paintColorAlpha),
    Colors.lightBlue.withAlpha(paintColorAlpha),
    Colors.cyan.withAlpha(paintColorAlpha),
    Colors.teal.withAlpha(paintColorAlpha),
    Colors.green.withAlpha(paintColorAlpha),
    Colors.lightGreen.withAlpha(paintColorAlpha),
    Colors.lime.withAlpha(paintColorAlpha),
    Colors.yellow.withAlpha(paintColorAlpha),
    Colors.amber.withAlpha(paintColorAlpha),
    Colors.orange.withAlpha(paintColorAlpha),
    Colors.deepOrange.withAlpha(paintColorAlpha),
    Colors.brown.withAlpha(paintColorAlpha),
    Colors.grey.withAlpha(paintColorAlpha),
    Colors.blueGrey.withAlpha(paintColorAlpha),
    Colors.black.withAlpha(paintColorAlpha),
  ];
  
  static const int painterPathCompressionLevel = 8;
  static const paintColorAlpha = 220;
  static const bottomBarHeight = 50.0;
  static const undoDisabledColor = Colors.black26;
  static const defaultThicknessMode = 2;
  static const bottomBarBackgroundColor = Color.fromARGB(255, 224, 224, 224);
  static var activeEraserBackground = defaultColor.withAlpha(150);
  static var defaultColor = Colors.amber;

  static const colorCircleItemSize = 50.0;

  static var swipeDeleteIconSize = 40.0;
  static var swipeDeleteBackgroundColor = Colors.red.withAlpha(200);
  static var swipeDeleteIconColor = Colors.white;

  static var noteItemTitleColor = Colors.black;
  static var noteItemDateColor = Colors.grey[700];
  static var noteItemAlternativeTitleColor = Colors.grey[500];
  static var noteItemSeparatorColor = Colors.grey[600];

  static String noteItemDateSameDayFormat = 'HH:mm';
  static String noteItemDateWithinWeekFormat = 'EEEE';
  static String noteItemDateMoreThanWeekFormat = 'dd/MM/yyyy';

}

class StringResources {

  static String appTitle = 'Drawable Notepad';

  // Erase whole drawing functionality
  static String eraseAlertTitle = "Are you sure?";
  static String eraseAlertContent = "Long pressing erase button will clear the whole drawing";
  static String eraseAlertYes = "Erase";
  static String eraseAlertNo = "Cancel";

  // Note list route
  static String noteRouteToolbarTitle = "Notepad";

  static String addNoteFABTooltip = 'Add note';

  static String noteItemDefaultTitle = "New note";
  static String noteItemHandwrittenNoteTitle = "Handwritten Note";
  static String noteItemDefaultAlternativeTitle = "No additional text";
  static String noteItemYesterdayText = "Yesterday";
}