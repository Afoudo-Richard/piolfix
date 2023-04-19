import 'package:poilfix/src/utils/utils.dart';

enum ReviewValidationError { empty }

class Review extends FormzInput<String, String> {
  const Review.pure() : super.pure('');
  const Review.dirty([String value = '']) : super.dirty(value);

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
