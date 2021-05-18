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
}
