import 'dart:math';

import 'package:intl/intl.dart';
import '../../app/data/models/note.dart';

class Helper {
  static int randomNumber() {
    Random random = Random();
    return random.nextInt(1000000);
  }

  static String formatDate(int ms) {
    var date = DateTime.fromMillisecondsSinceEpoch(ms);
    return DateFormat.yMMMd().add_jm().format(date);
  }

  static String generateNoteId() {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(10, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  static bool saveNote(Note note) {
    if (!["", null].contains(note.title) ||
        !["", null].contains(note.description) ||
        !["", null].contains(note.image)) return true;
    return false;
  }

  static bool uploadImage(Note note) {
    if (!["", null].contains(note.image) && !Uri.parse(note.image).isAbsolute)
      return true;
    return false;
  }

  static bool isUrl(String str) {
    return Uri.parse(str).isAbsolute;
  }
}
