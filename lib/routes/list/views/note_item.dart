import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(widget.note.noteText),
      ),
    );

    // TODO: Implement build
  }
}
