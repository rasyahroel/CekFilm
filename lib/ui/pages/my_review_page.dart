part of 'pages.dart';

class MyReviewPage extends StatefulWidget {
  @override
  _MyReviewPageState createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  final reviewController = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();

    reviewController.myReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackPrimary,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                color: Colors.black12,
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.05, horizontal: 24),
                child: Text('REVIEW KU',
                    style: whiteTextFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.05)),
              ),
              Obx(() => reviewController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: yellowPrimary,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                  : !reviewController.isLoading.value &&
                          reviewController.listMyReview == null
                      ? Center(child: Text('Tidak ada review'))
                      : Container(
                          child: Column(
                              children: reviewController.listMyReview
                                  .map(
                                    (element) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.put(MovieController())
                                              .fetchDetailMovie(
                                                  element.idMovie);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24),
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Stack(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: Get.width * 0.12,
                                                      height: Get.height * 0.15,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  baseUrlImageTmdbW500 +
                                                                      element
                                                                          .posterPath))),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 24),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            element.title,
                                                            style: whiteTextFont.copyWith(
                                                                fontSize:
                                                                    Get.height *
                                                                        0.015,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Text(
                                                              '"' +
                                                                  element
                                                                      .review +
                                                                  '"',
                                                              style:
                                                                  whiteTextFont),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                    bottom: Get.height * 0.01,
                                                    right: 0,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.thumb_up,
                                                          color: Colors.white,
                                                          size:
                                                              Get.height * 0.02,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          element.likeCount,
                                                          style: whiteTextFont,
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            )),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ))
            ],
          ),
        ));
  }
}
