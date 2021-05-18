part of 'services.dart';

class UtilsServices {
  static Future<List<Genre>> getListGenre() async {
    try {
      var response = await Dio()
          .get('https://shcproduction.com/ws-mobile/utils/list_genre');

      var data = jsonDecode(jsonEncode(response.data));
      List<Genre> value =
          (data['data'] as Iterable).map((e) => Genre.fromJson(e)).toList();
      return value;
    } catch (e) {
      print(e);
    }
  }

  // static Future<void> sendOtp(
  //     String phoneNumber, String verificationCode, int otp) async {
  //   try {
  //     // Dio dio = new Dio();
  //     // dio.options.headers[HttpHeaders.authorizationHeader] =
  //     //     "Auth-API4GW e427d445494725421c6f36e7e7b6c680";
  //     var response = await Dio().post('https://portal.api4gw.com/send',
  //         data: {
  //           'type': 'text',
  //           'message': 'Berikut kode otp kamu : ' +
  //               otp.toString() +
  //               'Verification ID : ' +
  //               verificationCode,
  //           'to': phoneNumber
  //         },
  //         options: Options(contentType: 'application/json', headers: {
  //           'Authorization': 'Auth-API4GW e427d445494725421c6f36e7e7b6c680',
  //         }));
  //     print(response);
  //     return true;
  //   } catch (e) {
  //     if (e is DioError) {
  //       print(e.message);
  //     }
  //   }
  // }
}
