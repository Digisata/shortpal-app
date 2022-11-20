import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  factory DioHelper() {
    return _mainDioHelper;
  }

  DioHelper._internal();

  static final DioHelper _mainDioHelper = DioHelper._internal();

  void _addDioLogger(Dio dio) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        compact: false,
      ),
    );
  }

  Dio getDio() {
    final BaseOptions option = BaseOptions(
      baseUrl: '${dotenv.env['BASE_URL']}${dotenv.env['API_VERSION']}',
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: 'application/json',
    );

    final Dio dio = Dio(option);
    if (!kReleaseMode) {
      _addDioLogger(dio);
    }
    return dio;
  }
}
