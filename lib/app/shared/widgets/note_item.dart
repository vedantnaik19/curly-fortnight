import 'package:flutter/material.dart';
import '../../../app/data/models/note.dart';
import 'image_widget.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({Key key, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !(["", null].contains(note.image))
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  child: ImageWidget(uri: note.image))
              : Container(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !(["", null].contains(note.title))
                    ? Text(note.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.headline6)
                    : Container(),
                SizedBox(
                  height: 4,
                ),
                !(["", null].contains(note.description))
                    ? Text(
                        note.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
