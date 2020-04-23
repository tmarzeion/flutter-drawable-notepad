import 'package:drawablenotepadflutter/const.dart';
import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:quiver/strings.dart';
import 'package:zefyr/zefyr.dart';

class NoteItem extends StatefulWidget {
  NoteItem({Key key, this.note, this.onNotePreviewRequested}) : super(key: key);

  final Note note;
  final Function onNotePreviewRequested;

  @override
  State<StatefulWidget> createState() {
    return new NoteItemState(note: note);
  }
}

class NoteItemState extends State<NoteItem> {
  NoteItemState({this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<NotepadDatabase>(context, listen: false);
    var notePlainText =
        NotusDocument.fromJson(json.decode(note.noteText) as List)
            .toPlainText();
    if (notePlainText.startsWith(" ")) {
      notePlainText = notePlainText.substring(1, notePlainText.length);
    }
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Settings.swipeDeleteBackgroundColor,
          iconWidget: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Settings.swipeDeleteIconColor,
                  size: Settings.swipeDeleteIconSize,
                )
              ],
            ),
          ),
          //icon: Icons.delete,
          onTap: () => database.deleteNote(widget.note),
        )
      ],
      child: GestureDetector(
        onLongPress: () => {widget.onNotePreviewRequested(widget.note, true)},
        onLongPressEnd: (d) =>
            widget.onNotePreviewRequested(widget.note, false),
        child: InkWell(
            onTap: () => AppNavigator.navigateToNoteEdit(context, note),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _getFirstLineOfText(notePlainText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Settings.noteItemTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(_getDateTimeAsNonNerdText(note.noteDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Settings.noteItemDateColor)),
                      SizedBox(width: 8.0),
                      Flexible(
                        child: Container(
                          child: Text(
                            _getSecondLineOfText(notePlainText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Settings.noteItemAlternativeTitleColor),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  // Nullable
  String _getNotBlankLine(String text, int lineIndex) {
    List<String> lines = new LineSplitter().convert(text);
    List<String> notBlankLines =
        lines.where((line) => isNotBlank(line)).toList();

    if (notBlankLines.length - 1 >= lineIndex) {
      return notBlankLines[lineIndex];
    } else {
      return null;
    }
  }

  String _getFirstLineOfText(String noteText) {
    return _getNotBlankLine(noteText, 0) ??
        StringResources.noteItemDefaultTitle;
  }

  // Nullable
  String _getSecondLineOfText(String noteText) {
    if (_getNotBlankLine(noteText, 0) == null) {
      return StringResources.noteItemHandwrittenNoteTitle;
    } else {
      return _getNotBlankLine(noteText, 1) ??
          StringResources.noteItemDefaultAlternativeTitle;
    }
  }

  String _getDateTimeAsNonNerdText(DateTime dateTime) {
    var now = new DateTime.now();

    int diffDays = now.difference(dateTime).inDays;

    switch (diffDays) {
      case 0:
        {
          return DateFormat(Settings.noteItemDateSameDayFormat)
              .format(dateTime);
        }
        break;

      case 1:
        {
          return StringResources.noteItemYesterdayText;
        }
        break;

      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        {
          return DateFormat(Settings.noteItemDateWithinWeekFormat)
              .format(dateTime);
        }
        break;

      default:
        {
          return DateFormat(Settings.noteItemDateMoreThanWeekFormat)
              .format(dateTime);
        }
        break;
    }
  }
}
