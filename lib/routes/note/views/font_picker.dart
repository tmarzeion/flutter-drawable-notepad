import 'package:flutter/material.dart';

class FontPicker extends StatefulWidget {
  FontPicker({Key key}) : super(key: key);

  @override
  _FontPickerState createState() => _FontPickerState();
}

class _FontPickerState extends State<FontPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: Icon(
          Icons.format_paint,
          size: 200,
        ),
      ),
      height: 250,
    );
  }
}

class MenuItem {
  const MenuItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<MenuItem> mainMenuItems = const <MenuItem>[
  const MenuItem(title: 'Search', icon: Icons.build),
];
