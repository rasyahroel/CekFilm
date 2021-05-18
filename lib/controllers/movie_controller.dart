part of 'controllers.dart';

class MovieController extends GetxController {
  var listNowPlaying = <Movie>[].obs;
  var listRamaiReview = <Movie>[].obs;
  var detailMovie = DetailMovie().obs;
  var isLoading = false.obs;
  var reviewController = Get.put(ReviewController());
  fetchNowPlaying() async {
    isLoading(true);
    List<Movie> result = await MovieServices.getNowPlaying();
    listNowPlaying.assignAll(result);
    isLoading(false);
  }

  fetchRamaiReview() async {
    isLoading(true);
    List<Movie> result = await MovieServices.getRamaiReview();
    listRamaiReview.assignAll(result);
    isLoading(false);
  }

  fetchDetailMovie(String movieId) async {
    DetailMovie result = await MovieServices.getDetailMovie(movieId);
    reviewController.fetchReviewMovie(result.id.toString());
    Get.to(DetailMoviePage());
    isLoading(true);

    detailMovie.value = result;
    if (detailMovie.value != null) {}
    isLoading(false);
  }
}
