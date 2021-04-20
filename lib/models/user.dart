import 'package:graphine_mobile_prototype/models/database_object.dart';

class User extends DatabaseObject {
  String name;
  String email;
  String phone;
  String photoUrl;

  User({
    String id,
    int createdAt,
    int updatedAt,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
  }) : super(
          'user',
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  User.empty() : super('user') {
    this.name = '';
    this.email = '';
    this.phone = '';
    this.photoUrl = '';
  }

  User.fromMap(Map<String, dynamic> map) : super.fromMap('user', map) {
    if (map == null) return;
    this.name = map['name'] as String;
    this.email = map['email'] as String;
    this.phone = map['phone'] as String;
    this.photoUrl = map['photoUrl'] as String;
  }

  @override
  Map<String, dynamic> toMap({bool withId = true, bool databaseReady = false}) {
    Map<String, dynamic> result = {
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'photoUrl': this.photoUrl,
      ...super.toMap(withId: withId, databaseReady: databaseReady),
    };

    result.removeWhere((key, value) => value == null);

    return result;
  }

  @override
  String toString() {
    return '${this.runtimeType}(${toMap()})';
  }
}
