class Validator {
  /// regex pour validator email
  static final RegExp _emailRegex =
      RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");

  /// validator pour les input text basic
  /// test si null ou si isEmpty
  static validatorInputTextBasic({String? textError, String? value}) {
    if (value == null || value.isEmpty) {
      return textError;
    }
    return null;
  }

  /// validator le contenue du input email
  /// test si null ou si isEmpty et la regex
  static validateEmail({String? textError, String? value}) {
    if (value == null || value.isEmpty || !_emailRegex.hasMatch(value)) {
      return textError;
    }
    return null;
  }

  /// validator le contenue du input password
  /// test si value est superieur à 6 caractere
  static validatePassword({String? textError, String? value}) {
    return value!.length < 6 ? textError : null;
  }
}