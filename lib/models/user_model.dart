part of 'models.dart';

class Users {
  String idUser;
  String email;
  String password;
  String namaDepan;
  String namaBelakang;
  String noHp;
  String profilePath;
  String sNope;
  String sEmail;
  List<String> kdGenre;
  String createdAt;
  String updateAt;

  Users(
      {this.idUser,
      this.email,
      this.password,
      this.namaDepan,
      this.namaBelakang,
      this.noHp,
      this.profilePath,
      this.sNope,
      this.sEmail,
      this.kdGenre,
      this.createdAt,
      this.updateAt});

  Users.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    email = json['email'];
    password = json['password'];
    namaDepan = json['nama_depan'];
    namaBelakang = json['nama_belakang'];
    noHp = json['no_hp'];
    profilePath = json['profile_path'];
    sNope = json['s_nope'];
    sEmail = json['s_email'];
    kdGenre = json['kd_genre'].cast<String>();
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['email'] = this.email;
    data['password'] = this.password;
    data['nama_depan'] = this.namaDepan;
    data['nama_belakang'] = this.namaBelakang;
    data['no_hp'] = this.noHp;
    data['profile_path'] = this.profilePath;
    data['s_nope'] = this.sNope;
    data['s_email'] = this.sEmail;
    data['kd_genre'] = this.kdGenre;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
