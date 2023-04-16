import 'package:poilfix/poilfix.dart';
import 'package:validators/validators.dart';

enum TaskerPricePerHrValidationError { empty }

class TaskerPricePerHr extends FormzInput<String, String> {
  const TaskerPricePerHr.pure() : super.pure('');
  const TaskerPricePerHr.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    if (value != null) {
      List<Map<String, dynamic>> validators = [
        {
          "validator": value.isNotEmpty,
          "errorMessage": "Please enter a value.",
        },
        {
          "validator": isInt(value),
          "errorMessage": "Please enter a number",
        },
      ];

      return validation(validators);
    }
    return null;
  }
}
