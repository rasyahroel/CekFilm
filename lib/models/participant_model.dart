part of 'models.dart';

class Participant {
  Users user;
  String sParticipant;

  Participant({this.user, this.sParticipant});

  Participant.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Users.fromJson(json['user']) : null;
    sParticipant = json['s_participant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['s_participant'] = this.sParticipant;
    return data;
  }
}
