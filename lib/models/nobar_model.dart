part of 'models.dart';

class Nobar {
  String idNobar;
  String userId;
  String movieId;
  String maxPerson;
  String ajakan;
  String freeTicket;
  String schedule;
  String idKab;
  String posterPath;
  String createdAt;
  String updateAt;
  String sNobar;
  String title;
  Users users;
  int participant;
  String namaKab;

  Nobar(
      {this.idNobar,
      this.userId,
      this.movieId,
      this.maxPerson,
      this.ajakan,
      this.freeTicket,
      this.schedule,
      this.idKab,
      this.posterPath,
      this.createdAt,
      this.updateAt,
      this.sNobar,
      this.title,
      this.users,
      this.participant,
      this.namaKab});

  Nobar.fromJson(Map<String, dynamic> json) {
    idNobar = json['id_nobar'];
    userId = json['user_id'];
    movieId = json['movie_id'];
    maxPerson = json['max_person'];
    ajakan = json['ajakan'];
    freeTicket = json['free_ticket'];
    schedule = json['schedule'];
    idKab = json['id_kab'];
    posterPath = json['poster_path'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    sNobar = json['s_nobar'];
    title = json['title'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    participant = json['participant'];
    namaKab = json['nama_kab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_nobar'] = this.idNobar;
    data['user_id'] = this.userId;
    data['movie_id'] = this.movieId;
    data['max_person'] = this.maxPerson;
    data['ajakan'] = this.ajakan;
    data['free_ticket'] = this.freeTicket;
    data['schedule'] = this.schedule;
    data['id_kab'] = this.idKab;
    data['poster_path'] = this.posterPath;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    data['s_nobar'] = this.sNobar;
    data['title'] = this.title;
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    data['participant'] = this.participant;
    data['nama_kab'] = this.namaKab;
    return data;
  }
}
