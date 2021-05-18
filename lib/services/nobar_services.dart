part of 'services.dart';

class NobarServices {
  static Future<List<Nobar>> getNobar() async {
    try {
      var response =
          await Dio().get('https://shcproduction.com/ws-mobile/nobar/nobar');

      var data = jsonDecode(jsonEncode(response.data));
      List<Nobar> value =
          (data['data'] as Iterable).map((e) => Nobar.fromJson(e)).toList();
      return value;
    } catch (e) {
      print(e);
    }
  }
}
