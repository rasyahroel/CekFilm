part of 'services.dart';

class ReviewServices {
  static Future<List<Review>> getReviewMovieId(String idMovie) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/review/get_review_movie',
          queryParameters: {"id_movie": idMovie});

      var data = jsonDecode(jsonEncode(response.data));
      List<Review> value =
          (data['data'] as Iterable).map((e) => Review.fromJson(e)).toList();

      if (value.length == 0 || value == null) {
        return <Review>[];
      } else {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Review>> getMyReview(String idUser) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/review/my_review',
          queryParameters: {"id_user": idUser});

      var data = jsonDecode(jsonEncode(response.data));
      if (data['status'] == 2) {
        return <Review>[];
      } else {
        List<Review> value =
            (data['data'] as Iterable).map((e) => Review.fromJson(e)).toList();

        return value;
      }
    } catch (e) {
      print(e);
      print('asdasd');
      return <Review>[];
    }
  }

  static Future<bool> sendReview(
      String review, String idMovie, String idUser) async {
    try {
      var response = await Dio().post(
          'https://shcproduction.com/ws-mobile/review/send_review',
          data: {"review": review, "id_movie": idMovie, "id_user": idUser});

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> feedbackReview(
      String idReview, String action, String idUser) async {
    try {
      print(idReview);
      print(idUser);
      print(action);
      var response = await Dio().post(
          'https://shcproduction.com/ws-mobile/review/feedback_review',
          data: {"id_review": idReview, "action": action, "id_user": idUser});

      var data = jsonDecode(jsonEncode(response.data));
      var result = data['status'];
      return result == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
