part of 'services.dart';

class AuthServices {
  Future<int> checkEmail(String email) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/auth/check_email_user',
          queryParameters: {'email': email});

      var data = jsonDecode(jsonEncode(response.data));
      int status = data['status'];
      return status;
    } catch (e) {
      print(e);
    }
  }

  Future<Users> signUpUser(RegistrationData registrationData) async {
    try {
      var response = await Dio()
          .post('https://shcproduction.com/ws-mobile/auth/sign_up_user', data: {
        'id_user': registrationData.idUser,
        'email': registrationData.email,
        'password': registrationData.password,
        'nama_depan': registrationData.namaDepan,
        'nama_belakang': registrationData.namaBelakang,
        'no_hp': '+62' + registrationData.noHp,
        'kd_genre': registrationData.selectedGenres.toString()
      });

      var data = jsonDecode(jsonEncode(response.data));
      print(data);
      Map<String, dynamic> result = data['data'];
      Users user = Users.fromJson(result);
      printPrettyJson(data, indent: 2);
      return user;
    } catch (e) {
      if (e is DioError) {
        print(e.response.toString());
      } else {
        print(e.toString());
      }
    }
  }
}
