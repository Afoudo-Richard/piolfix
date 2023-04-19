import 'package:poilfix/src/utils/utils.dart';
import 'package:validators/validators.dart';

enum RatingValidationError { empty }

class Rating extends FormzInput<String, String> {
  const Rating.pure() : super.pure('');
  const Rating.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": double.parse(value) > 0,
          "errorMessage": "Rating must be great than 0",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
