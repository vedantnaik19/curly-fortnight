import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/constants/db_keys.dart';
import 'package:stack_fin_notes/app/core/services/auth_service.dart';
import 'package:stack_fin_notes/app/data/models/note.dart';

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

  Future<void> syncUser(User user, [String name]) async {
    DocumentReference users = _firestore.collection(DbKeys.USERS).doc(user.uid);
    return await users.set(
        {DbKeys.NAME: name ?? user.displayName ?? "", DbKeys.EMAIL: user.email},
        SetOptions(merge: true));
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
