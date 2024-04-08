import 'package:dio/dio.dart';

class PaymentApiService {
  Dio dio = Dio();

  Future<Response> post(
      {required String url,
      required dynamic body,
      required String token,
      String? contentType,
      Map<String, String>? header}) async {
    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          contentType: contentType,
          headers: header ??
              {
                'Authorization': "Bearer $token",
              },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}
