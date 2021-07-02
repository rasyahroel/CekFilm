part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getNowPlaying() async {
    try {
      var response = await Dio()
          .get('https://shcproduction.com/ws-mobile/movie/now_playing');

      var data = jsonDecode(jsonEncode(response.data));
      List<Movie> value =
          (data['data'] as Iterable).map((e) => Movie.fromJson(e)).toList();
      return value;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Movie>> getRamaiReview() async {
    try {
      var response = await Dio()
          .get('https://shcproduction.com/ws-mobile/movie/movie_ramai_review');

      var data = jsonDecode(jsonEncode(response.data));
      List<Movie> value =
          (data['data'] as Iterable).map((e) => Movie.fromJson(e)).toList();
      return value;
    } catch (e) {
      print(e);
    }
  }

  static Future<DetailMovie> getDetailMovie(String idmovie) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/movie/detail_movie',
          queryParameters: {'id_movie': idmovie});

      var data = jsonDecode(jsonEncode(response.data));
      DetailMovie value = DetailMovie.fromJson(data['data']);
      return value;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Movie>> searchMovie(String keyword, int page) async {
    try {
      var response = await Dio().get(
          'https://shcproduction.com/ws-mobile/movie/search_movie',
          queryParameters: {'keyword': keyword, 'page': page.toString()});
      var data = jsonDecode(jsonEncode(response.data));
      print(response.statusCode);
      List<Movie> value =
          (data['data'] as Iterable).map((e) => Movie.fromJson(e)).toList();
      return value;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
