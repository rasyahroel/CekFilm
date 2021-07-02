part of 'controllers.dart';

class MovieController extends GetxController {
  var listNowPlaying = <Movie>[].obs;
  var searchList = <Movie>[].obs;
  var oldSearch = <Movie>[].obs;
  var listRamaiReview = <Movie>[].obs;
  var detailMovie = DetailMovie().obs;
  var isLoading = false.obs;
  var key = "".obs;
  var isMoreDataAvailable = true.obs;
  var reviewController = Get.put(ReviewController());

  @override
  void onInit() {
    super.onInit();
    fetchNowPlaying();
    fetchRamaiReview();
  }

  fetchNowPlaying() async {
    isLoading(true);
    List<Movie> result = await MovieServices.getNowPlaying();
    listNowPlaying
        .assignAll(result.where((element) => element.posterPath != ""));
    isLoading(false);
  }

  fetchRamaiReview() async {
    isLoading(true);
    List<Movie> result = await MovieServices.getRamaiReview();
    listRamaiReview.assignAll(result);
    isLoading(false);
  }

  fetchDetailMovie(String movieId, {bool isNowPlaying = false}) async {
    DetailMovie result = await MovieServices.getDetailMovie(movieId);
    // print('asdasd' + result.id.toString());
    reviewController.fetchReviewMovie(result.id.toString());
    Get.to(DetailMoviePage(
      isNowPlaying: isNowPlaying,
    ));
    isLoading(true);

    detailMovie.value = result;
    if (detailMovie.value != null) {}
    isLoading(false);
  }

  getSearchMovie(String keywordSearch, int page) async {
    try {
      isMoreDataAvailable(false);
      isLoading(true);

      if (key.value != keywordSearch) {
        searchList.clear();
      }
      key.value = keywordSearch;
      print(key.value);

      await MovieServices.searchMovie(keywordSearch, page).then((resp) {
        isLoading(false);
        searchList.addAll(resp.where((element) => element.posterPath != ""));
      }, onError: (err) {
        isLoading(false);
      });
    } catch (exception) {
      print(exception);
      isLoading(false);
    }
  }

  void getMoreMovie(String keywordSearch, int page) async {
    try {
      isLoading(true);
      getSearchMovie(keywordSearch, page);
    } catch (exception) {
      isLoading(false);

      isMoreDataAvailable(false);
      Get.snackbar('Exception', exception,
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // searchMovie(String keyword) {
  //   final currentState = searchList;
  //   var oldData = <Movie>[];

  //   if (cusPage != null) {
  //     page = cusPage;
  //   } else {
  //     prev ? page-- : page++;
  //   }

  //   emit(GithubSearchUserLoading(oldData, indexOldData,
  //       isFirstFetch: page == 1));

  //   repository.searchGithubUsers(username, cusPage ?? page).then((value) {
  //     hitApiCount++;
  //     if (value.statusCode == 304) {
  //       emit(GithubSearchNotFound('Tidak termodifikasi', value.statusCode));
  //     } else if (value.statusCode == 422) {
  //       emit(GithubSearchNotFound(
  //           'Pencarian tidak dapat di proses', value.statusCode));
  //     } else if (value.statusCode == 503) {
  //       emit(GithubSearchNotFound(
  //           'Layanan tidak tersedia, silahkan coba kembali nanti',
  //           value.statusCode));
  //     } else if (value.value == null) {
  //       emit(GithubSearchNotFound('Data tidak ditemukan', value.statusCode));
  //     } else {
  //       final users = (state as GithubSearchUserLoading).users;
  //       users.addAll(value.value);
  //       indexOldData.addAll(value.value);
  //       if (users.isEmpty) {
  //         emit(GithubSearchNotFound('Data tidak ditemukan', 404));
  //       } else {
  //         pageSize = value.pageSize.toInt();
  //         emit(GithubSearchUserLoaded(users, indexOldData));
  //       }
  //     }
  //   });
  // }
}
