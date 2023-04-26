import 'package:poilfix/src/utils/utils.dart';

enum TaskDetailsValidationError { empty }

class TaskDetails extends FormzInput<String, String> {
  const TaskDetails.pure() : super.pure('');
  const TaskDetails.dirty([String value = '']) : super.dirty(value);

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
