import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteItem extends StatefulWidget {
  NoteItem({this.note});

  final Note note;

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

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.redAccent[100],
          iconWidget: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          //icon: Icons.delete,
          onTap: () => database.deleteNote(widget.note),
        )
      ],
      child: InkWell(
        onTap: () => print('test'),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  _getFirstLineOfText(note.noteText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Text(_getDateTimeAsNonNerdText(note.noteDate),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700])),
                  SizedBox(width: 8.0),
                  Flexible(
                    child: Container(
                      child: Text(
                        _getSecondLineOfText(note.noteText),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

    // TODO: Implement build
  }

  String _getFirstLineOfText(String noteText) {
    if (noteText.contains("\n")) {
      return noteText.substring(0, noteText.indexOf("\n"));
    } else {
      return noteText;
    }
  }

  // Nullable
  String _getSecondLineOfText(String noteText) {
    if (noteText.contains("\n")) {
      return _getFirstLineOfText(noteText.substring(
          noteText.indexOf("\n") + "\n".length, noteText.length - 1));
    } else {
      return "No additional text";
    }
  }

  String _getDateTimeAsNonNerdText(DateTime dateTime) {
    var now = new DateTime.now();

    int diffDays = now.difference(dateTime).inDays;

    switch (diffDays) {
      case 0:
        {
          return DateFormat('HH:mm').format(dateTime);
        }
        break;

      case 1:
        {
          return "Yesterday";
        }
        break;

      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        {
          return DateFormat('EEEE').format(dateTime);
        }
        break;

      default:
        {
          return DateFormat('dd/MM/yyyy').format(dateTime);
        }
        break;
    }
  }
}
