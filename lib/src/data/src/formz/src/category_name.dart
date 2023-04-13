import 'package:poilfix/poilfix.dart';

enum CategoryNameValidationError { empty }

class CategoryName extends FormzInput<String, String> {
  const CategoryName.pure() : super.pure('');
  const CategoryName.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value.",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
