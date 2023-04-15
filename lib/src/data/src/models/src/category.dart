import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Category extends ParseObject implements ParseCloneable {
  Category() : super(keyTableName);
  Category.clone() : this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map<String, dynamic> map) => Category.clone()..fromJson(map);

  static const String keyTableName = 'Categories';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  String? get description => get<String?>('description');
  set description(String? value) => set<String?>('description', value);

  // String? get imageThumbnailUrl => get<String?>('image_thumbnail_url');
  // set imageThumbnailUrl(String? value) =>
  //     set<String?>('image_thumbnail_url', value);

  ParseFile? get imageThumbnail => get('image_thumbnail');

  set imageThumbnail(value) => set('image_thumbnail', value);

  String? imageThumbnailUrl;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
      'description': description,
      'imageThumbnailUrl': imageThumbnailUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null
      ..imageThumbnailUrl = map['imageThumbnailUrl'] != null
          ? map['imageThumbnailUrl'] as String
          : null
      ..description =
          map['description'] != null ? map['description'] as String : null;
  }
}
