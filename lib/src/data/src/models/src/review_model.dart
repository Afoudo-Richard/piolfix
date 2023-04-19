import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

class ReviewModel extends ParseObject implements ParseCloneable {
  ReviewModel() : super(keyTableName);
  ReviewModel.clone() : this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map<String, dynamic> map) => ReviewModel.clone()..fromJson(map);

  static const String keyTableName = 'Reviews';

  String? get review => get<String?>('review');
  set review(String? value) => set<String?>('review', value);

  num? get rating => get<num?>('rating');
  set rating(num? value) => set<num?>('rating', value);

  User? get user => get('user');
  set user(User? value) => set<User?>('user', value);

  User? get tasker => get<User?>('tasker');
  set tasker(User? value) => set<User?>('tasker', value);
}
