import 'package:poilfix/src/utils/utils.dart';

enum TaskerToolValidationError { empty }

class TaskerTool extends FormzInput<String, String> {
  const TaskerTool.pure() : super.pure('');
  const TaskerTool.dirty([String value = '']) : super.dirty(value);

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
