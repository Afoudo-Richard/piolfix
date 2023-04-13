// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:poilfix/poilfix.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

class User extends ParseUser with EquatableMixin implements ParseCloneable {
  User({
    String? username,
    String? password,
    String? email,
  }) : super(username, password, email);

  User.clone() : this();

  @override
  User clone(Map<String, dynamic> map) => User.clone()..fromJson(map);

  String? get firstname => get<String?>('firstname');
  set firstname(String? value) => set<String?>('firstname', value);

  String? get lastname => get<String?>('lastname');
  set lastname(String? value) => set<String?>('lastname', value);

  String? get email => get<String?>('email');
  set email(String? value) => set<String?>('email', value);

  String? get phone => get<String?>('phone');
  set phone(String? value) => set<String?>('phone', value);

  String? get gender => get<String?>('gender');
  set gender(String? value) => set<String?>('gender', value);

  String? get profileImage => get<String?>('profileImage');
  set profileImage(String? value) => set<String?>('profileImage', value);

  bool get isAdmin => get<bool?>('is_admin') ?? false;
  set isAdmin(bool value) => set<bool?>('is_admin', value);

  List<dynamic>? get devices => get('devices');
  set devices(List<dynamic>? value) => set('devices', value);

  @override
  List<Object?> get props => [
        firstname,
        lastname,
        email,
        phone,
        gender,
        profileImage,
        isAdmin,
        devices,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'gender': gender,
      'profileImage': profileImage,
      'sessionToken': sessionToken,
      'isAdmin': isAdmin,
      'devices': devices,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    User user = User()
      ..objectId = map['objectId']
      ..firstname = map['firstname'] != null ? map['firstname'] as String : null
      ..lastname = map['lastname'] != null ? map['lastname'] as String : null
      ..email = map['email'] != null ? map['email'] as String : null
      ..phone = map['phone'] != null ? map['phone'] as String : null
      ..gender = map['gender'] != null ? map['gender'] as String : null
      ..profileImage =
          map['profileImage'] != null ? map['profileImage'] as String : null
      ..sessionToken =
          map['sessionToken'] != null ? map['sessionToken'] as String : null
      ..isAdmin = map['isAdmin'] as bool
      ..devices =
          map['devices'] != null ? map['devices'] as List<dynamic> : null;

    return user;
  }

  String to_json() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
