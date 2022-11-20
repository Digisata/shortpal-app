import 'package:shortpal/text_data.dart';

class ValidatorHelper {
  factory ValidatorHelper() {
    return _mainValidatorHelper;
  }

  ValidatorHelper._internal();

  static final ValidatorHelper _mainValidatorHelper =
      ValidatorHelper._internal();

  String? validateBasic(String? value) {
    if (value!.isEmpty) {
      return TextData.textPleaseFillFirst;
    } else {
      return null;
    }
  }
}
