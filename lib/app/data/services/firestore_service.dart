import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../app/core/constants/db_keys.dart';
import '../../../app/core/services/auth_service.dart';
import '../../../app/data/models/db_user.dart';
import '../../../app/data/models/note.dart';

class FirestoreService extends GetxService {
  final AuthService _authService = Get.find();

  FirebaseFirestore _firestore;

  FirebaseFirestore get firestore => _firestore;

  DocumentReference get userDocRef =>
      _firestore.collection(DbKeys.USERS).doc(_authService.currentUser.uid);

  CollectionReference get notesRef => _firestore
      .collection(DbKeys.USERS)
      .doc(_authService.currentUser.uid)
      .collection(DbKeys.NOTES);

  @override
  void onInit() {
    _firestore = FirebaseFirestore.instance;
    super.onInit();
  }

  Future<void> syncUser(DbUser user) async {
    DocumentReference users = _firestore.collection(DbKeys.USERS).doc(user.id);
    await users.set(user.toJson(), SetOptions(merge: true));
  }

  void saveNote(Note note) {
    userDocRef
        .collection(DbKeys.NOTES)
        .doc(note.id)
        .set(note.toJson(), SetOptions(merge: true));
  }

  void deleteNote(Note note) {
    userDocRef.collection(DbKeys.NOTES).doc(note.id).delete();
  }

  Stream<QuerySnapshot> getNotes() {
    return notesRef.orderBy(DbKeys.CREATED_AT, descending: true).snapshots();
  }
}
