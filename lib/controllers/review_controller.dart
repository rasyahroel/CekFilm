part of 'controllers.dart';

class ReviewController extends GetxController {
  var listReviewMovie = <Review>[].obs;
  var listMyReview = <Review>[].obs;
  var isLoading = false.obs;
  var pref = GetStorage();

  fetchReviewMovie(String idMovie) async {
    listReviewMovie.clear();
    isLoading(true);
    List<Review> result = await ReviewServices.getReviewMovieId(idMovie);
    if (result != null) {
      listReviewMovie.assignAll(result);
    }
    isLoading(false);
  }

  sendReview(String review, String idMovie) async {
    isLoading(true);
    bool send =
        await ReviewServices.sendReview(review, idMovie, pref.read('idUser'));
    if (send) {
      fetchReviewMovie(idMovie);
    } else {
      Get.snackbar('Error', 'Terjadi kesalahan',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading(false);
  }

  feedbackReview(String idReview, String action) async {
    bool send = await ReviewServices.feedbackReview(
        idReview, action, pref.read('idUser'));
    print(send);
    if (send) {
      Get.snackbar('Berhasil', 'Berhasil ${action} review ini',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Terjadi kesalahan',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading(false);
  }

  myReview() async {
    isLoading(true);
    List<Review> list = await ReviewServices.getMyReview(pref.read('idUser'));
    if (list != null) {
      listMyReview.assignAll(list);
      isLoading(false);
    }
    isLoading(false);
  }
}
