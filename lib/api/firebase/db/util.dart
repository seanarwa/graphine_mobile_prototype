import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUtil {
  FirestoreUtil._();

  static DocumentReference getRef(String collection, String id) {
    return FirebaseFirestore.instance.collection(collection).doc(id);
  }

  static Future<Map<String, dynamic>> _fetchRefData(
      DocumentReference ref) async {
    if (ref == null) {
      return null;
    }
    Map<String, dynamic> dataMap = (await ref.get()).data();
    if (dataMap == null) {
      return null;
    }
    dataMap['id'] = ref.id;
    return dataMap;
  }

  static Future<Map<String, dynamic>> autoPopulate(
      Map<String, dynamic> map) async {
    if (map == null) return null;
    for (String key in map.keys) {
      if (map[key] is DocumentReference) {
        map[key] = await _fetchRefData(map[key]);
        map[key] = await autoPopulate(map[key]);
      } else if (map[key] is List) {
        for (int i = 0; i < map[key].length; i++) {
          if (map[key][i] is DocumentReference) {
            map[key][i] = await _fetchRefData(map[key][i]);
            map[key][i] = await autoPopulate(map[key][i]);
          } else if (map[key][i] is Map<String, dynamic>) {
            map[key][i] = await autoPopulate(map[key][i]);
          }
        }
      } else if (map[key] is Map<String, dynamic>) {
        map[key] = await autoPopulate(map[key]);
      }
    }
    return map;
  }
}
