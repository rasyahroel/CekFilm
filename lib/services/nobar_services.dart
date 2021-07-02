part of 'services.dart';

class NobarServices {
  static Future<List<Nobar>> getNobar() async {
    try {
      var response =
          await Dio().get('https://shcproduction.com/ws-mobile/nobar/nobar');

      var data = jsonDecode(jsonEncode(response.data));
      if (response.statusCode != 200) {
        return [];
      }
      List<Nobar> value =
          (data['data'] as Iterable).map((e) => Nobar.fromJson(e)).toList();
      return value;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Participant>> getListParticipant(String idNobar) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/nobar/list_participant',
          queryParameters: {'id_nobar': idNobar});

      var data = jsonDecode(jsonEncode(response.data));
      if (response.statusCode != 200) {
        return [];
      }
      List<Participant> value = (data['data'] as Iterable)
          .map((e) => Participant.fromJson(e))
          .toList();
      return value;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Nobar>> getMyNobar(String idUser) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/nobar/my_nobar',
          queryParameters: {'id_user': idUser});

      var data = jsonDecode(jsonEncode(response.data));
      List<Nobar> value = [];
      if (data['status'] == 0) {
        return [];
      } else {
        value =
            (data['data'] as Iterable).map((e) => Nobar.fromJson(e)).toList();
      }

      return value;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> createNobar(
      String idUser,
      String idMovie,
      String maxPerson,
      String ajakan,
      String freeTicket,
      String schedule,
      String idKab,
      String posterPath) async {
    try {
      var response = await Dio().post(
          'https://shcproduction.com/ws-mobile/nobar/create_nobar',
          data: {
            "id_user": idUser,
            "id_movie": idMovie,
            "max_person": maxPerson,
            "ajakan": ajakan,
            "free_ticket": freeTicket,
            "schedule": schedule,
            "id_kab": idKab,
            "poster_path": posterPath
          });

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> joinNobar(String idNobar, String idUser) async {
    try {
      var response = await Dio().post(
          'https://shcproduction.com/ws-mobile/nobar/join_nobar',
          data: {"id_nobar": idNobar, "id_user": idUser});

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> selesaiNobar(String idNobar) async {
    try {
      var response = await Dio().post(
          'https://shcproduction.com/ws-mobile/nobar/selesai_nobar',
          data: {
            "id_nobar": idNobar,
          });

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> batalkanNobar(String idNobar) async {
    try {
      var response = await Dio()
          .post('https://shcproduction.com/ws-mobile/nobar/hapus_nobar', data: {
        "id_nobar": idNobar,
      });

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> accNobar(String idUser, String idNobar) async {
    try {
      var response = await Dio().post(
          'https://shcproduction.com/ws-mobile/nobar/acc_participant',
          data: {
            "id_user": idUser,
            "id_nobar": idNobar,
          });

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
