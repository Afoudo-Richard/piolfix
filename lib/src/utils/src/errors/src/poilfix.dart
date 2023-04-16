class PoilfixApiError implements Exception {
  PoilfixApiError({this.message, this.errors});
  final String? message;
  final Map<String, dynamic>? errors;

  String? get getErrorsAsString {
    var errorList = [];

    if (errors != null) {
      for (var v in errors!.values) {
        var errList = v as List;
        errorList = List.of(errorList)..addAll(errList);
      }

      return errorList.join('\n');
    }

    return null;
  }
}

class ErrorRegistering extends PoilfixApiError {
  ErrorRegistering({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorLoggingIn extends PoilfixApiError {
  ErrorLoggingIn({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorUpdatingUser extends PoilfixApiError {
  ErrorUpdatingUser({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorAddingCategory extends PoilfixApiError {
  ErrorAddingCategory({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorUpdatingUserProfile extends PoilfixApiError {
  ErrorUpdatingUserProfile({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorUpdatingUserProfileImage extends PoilfixApiError {
  ErrorUpdatingUserProfileImage({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorRequestingCamPayPayment extends PoilfixApiError {
  ErrorRequestingCamPayPayment({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}

class ErrorRequestingCamPayToken extends PoilfixApiError {
  ErrorRequestingCamPayToken({
    String? message,
    Map<String, dynamic>? errors,
  }) : super(
          message: message,
          errors: errors,
        );
}
