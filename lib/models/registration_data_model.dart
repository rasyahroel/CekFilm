part of 'models.dart';

class RegistrationData {
  bool google;
  String idUser;
  String namaDepan;
  String namaBelakang;
  String email;
  String password;
  String noHp;
  List<String> selectedGenres;
  // String selectedLang;
  File profileImage;

  RegistrationData(
      {this.google = false,
      this.idUser,
      this.namaDepan = "",
      this.namaBelakang = "",
      this.email = "",
      this.password = "",
      this.noHp = "",
      this.selectedGenres = const []});
}
