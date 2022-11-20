import 'package:dio/dio.dart';
import 'package:shortpal/constant_data.dart';
import 'package:shortpal/helpers/dio_helper.dart';
import 'package:shortpal/text_data.dart';
import 'package:shortpal/url_model.dart';

final DioHelper _mainDioHelper = DioHelper();

class ApiService {
  factory ApiService() {
    return _apiService;
  }

  ApiService._internal();

  static final ApiService _apiService = ApiService._internal();

  Future<dynamic> shortUrl(Map<String, dynamic> body) async {
    try {
      final response = await _mainDioHelper.getDio().post(
            ConstantData.shortUrl,
            data: body,
          );

      if (response.statusCode == 200) {
        final UrlModel result =
            UrlModel.fromJson(response.data as Map<String, dynamic>);
        if (result.meta.status == TextData.textSuccessResponse) {
          return result;
        } else {
          return result.meta.message;
        }
      }
    } on DioError catch (_) {
      return ConstantData.somethingWentWrong;
    }
  }
}
