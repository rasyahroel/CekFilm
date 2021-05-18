part of 'extensions.dart';

extension FirebaseUserExtension on User {
  Users convertToUser(
          {String idUser = "",
          String namaDepan = "None",
          String namaBelakang = "None",
          String password = "",
          List<String> kdGenre = const [],
          String email = "None",
          String noHp = "0"}) =>
      Users(
          idUser: this.uid,
          email: this.email,
          password: password,
          namaDepan: namaDepan,
          namaBelakang: namaBelakang,
          kdGenre: kdGenre,
          noHp: noHp);

  Future<Users> fromFireStore() async => await UserServices.getUser(this.uid);
}
