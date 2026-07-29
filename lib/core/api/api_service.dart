import 'package:dio/dio.dart';
import 'package:movie_app/core/utils/constants.dart';

class ApiService {
  Dio dio = Dio();

  Future<Response> getData(String url) async {
    return await dio.get(
      url,
      options: Options(
        headers: {
          "Authorization": "Bearer ${ApiConstants.bearerToken}",
        },
      ),
    );
  }
}