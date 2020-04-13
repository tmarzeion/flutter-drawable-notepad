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
      color: Color.fromARGB(255, 224, 224, 224),
      child: Center(
        child: Text(
          "Draw options (in progress)"
        ),
      ),
      height: 50,
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
