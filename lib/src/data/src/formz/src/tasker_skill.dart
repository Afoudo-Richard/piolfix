import 'package:poilfix/src/utils/utils.dart';

enum TaskerSkillValidationError { empty }

class TaskerSkill extends FormzInput<String, String> {
  const TaskerSkill.pure() : super.pure('');
  const TaskerSkill.dirty([String value = '']) : super.dirty(value);

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
