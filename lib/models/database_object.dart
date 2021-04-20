import 'package:graphine_mobile_prototype/api/firebase/db/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseObject {
  String collection;
  String id;
  int createdAt;
  int updatedAt;

  DatabaseObject(
    this.collection, {
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  DatabaseObject.fromMap(String collection, Map<String, dynamic> map) {
    this.collection = collection;
    if (map == null) return;
    this.id = map['id'] as String;
    this.createdAt = map['createdAt'] as int;
    this.updatedAt = map['updatedAt'] as int;
  }

  DocumentReference get ref {
    if (id == null) {
      return null;
    }
    return FirestoreUtil.getRef(this.collection, this.id);
  }

  Map<String, dynamic> toMap({bool withId = true, bool databaseReady = false}) {
    Map<String, dynamic> map = {
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    };
    if (withId) {
      map['id'] = this.id;
    }

    map.removeWhere((key, value) => value == null);

    return map;
  }

  dynamic refOrMap(DatabaseObject object, {bool databaseReady = false}) {
    if (object == null) {
      return null;
    }
    return databaseReady ? object.ref : object.toMap();
  }

  @override
  String toString() {
    return '${this.runtimeType}(${toMap()})';
  }
}
