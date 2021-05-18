part of 'controllers.dart';

class ReviewController extends GetxController {
  var listReviewMovie = <Review>[].obs;
  var isLoading = false.obs;

  fetchReviewMovie(String idMovie) async {
    isLoading(true);
    List<Review> result = await ReviewServices.getReviewMovieId(idMovie);
    if (result != null) {
      listReviewMovie.assignAll(result);
    }
    isLoading(false);
  }
}
