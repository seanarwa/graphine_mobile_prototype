import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graphine_mobile_prototype/models/user.dart';

class UserAPI {
  static final String databaseId = '[Default]';
  static final String collectionId = 'user';
  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection(collectionId);

  UserAPI._();

  static Future<bool> exists(String id) async {
    try {
      DocumentSnapshot snapshot = await _ref.doc(id).get();
      return snapshot.exists;
    } catch (e) {
      throw "Failed to check if document exists $databaseId/$collectionId/$id: $e";
    }
  }

  static Future<User> get(String id) async {
    if (id == null) return null;
    try {
      Map<String, dynamic> dataMap = (await _ref.doc(id).get()).data();
      if (dataMap == null) {
        return null;
      }
      dataMap["id"] = id;
      return User.fromMap(dataMap);
    } catch (e) {
      throw "Failed to find document $databaseId/$collectionId/$id: $e";
    }
  }

  static Future<List<User>> getMultiple(List<String> ids) async {
    List<Future<User>> futures = [];
    for (String id in ids ?? []) {
      futures.add(get(id));
    }
    return await Future.wait(futures);
  }

  static Future<User> fetch(DocumentReference ref) async {
    if (ref == null) return null;
    Map<String, dynamic> dataMap = (await ref.get()).data();
    dataMap['id'] = ref.id;
    return User.fromMap(dataMap);
  }

  static Future<List<User>> fetchMultiple(
      List<DocumentReference> refs) async {
    List<Future<User>> futures = [];
    for (DocumentReference ref in refs ?? []) {
      futures.add(fetch(ref));
    }
    return await Future.wait(futures);
  }

  static Future<User> add(User user) async {
    if (user == null) return null;
    try {
      user.createdAt = DateTime.now().millisecondsSinceEpoch;
      user.updatedAt = user.createdAt;
      DocumentReference ref = await _ref.add(user.toMap(
        withId: false,
        databaseReady: true,
      ));
      user.id = ref.id;
      return user;
    } catch (e) {
      throw "Failed to add document to $databaseId/$collectionId: $e";
    }
  }

  static Future<void> set(User user) async {
    if (user == null) return;
    try {
      user.updatedAt = DateTime.now().millisecondsSinceEpoch;
      await _ref.doc(user.id).set(
            user.toMap(
              withId: false,
              databaseReady: true,
            ),
            SetOptions(merge: true),
          );
    } catch (e) {
      throw "Failed to set document $databaseId/$collectionId/${user.id}: $e";
    }
  }

  static Future<void> delete(String id) async {
    if (id == null) return;
    try {
      await _ref.doc(id).delete();
    } catch (e) {
      throw "Failed to delete document $databaseId/$collectionId/$id: $e";
    }
  }

  static Stream<User> onChanged(String id) async* {
    try {
      Stream<DocumentSnapshot> snapshots = _ref.doc(id).snapshots();
      await for (DocumentSnapshot snapshot in snapshots) {
        Map<String, dynamic> dataMap = snapshot.data();
        if (dataMap != null) {
          dataMap["id"] = snapshot.id;
          yield User.fromMap(dataMap);
        }
      }
    } catch (e) {
      throw "Failed to listen changes of $databaseId/$collectionId/$id: $e";
    }
  }
}
