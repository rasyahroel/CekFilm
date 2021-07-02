part of 'models.dart';

class Review {
  String idReview;
  String idUser;
  String idMovie;
  String review;
  String likeCount;
  String reportCount;
  String isLiked;
  String isReport;
  String sReview;
  String createdAt;
  String posterPath;
  String title;
  Users users;

  Review(
      {this.idReview,
      this.idUser,
      this.idMovie,
      this.review,
      this.likeCount,
      this.reportCount,
      this.isLiked,
      this.isReport,
      this.posterPath,
      this.title,
      this.sReview,
      this.createdAt,
      this.users});

  Review.fromJson(Map<String, dynamic> json) {
    idReview = json['id_review'];
    idUser = json['id_user'];
    idMovie = json['id_movie'];
    review = json['review'];
    posterPath = json['poster_path'] ?? "";
    title = json['title'] ?? "";
    likeCount = json['like_count'];
    reportCount = json['report_count'];
    isLiked = json['is_liked'];
    isReport = json['is_report'];
    sReview = json['s_review'];
    createdAt = json['created_at'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_review'] = this.idReview;
    data['id_user'] = this.idUser;
    data['id_movie'] = this.idMovie;
    data['review'] = this.review;
    data['like_count'] = this.likeCount;
    data['report_count'] = this.reportCount;
    data['is_liked'] = this.isLiked;
    data['is_report'] = this.isReport;
    data['s_review'] = this.sReview;
    data['created_at'] = this.createdAt;
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    return data;
  }
}
