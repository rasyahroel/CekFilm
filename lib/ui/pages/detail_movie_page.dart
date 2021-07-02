part of 'pages.dart';

class DetailMoviePage extends StatefulWidget {
  final bool isNowPlaying;
  DetailMoviePage({this.isNowPlaying});
  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  MovieController movieController = Get.put(MovieController());
  ReviewController reviewController = Get.put(ReviewController());
  UtilsController utilsController = Get.put(UtilsController());
  TextEditingController tReview = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          movieController.detailMovie.value.title ?? '',
          style: whiteTextFont.copyWith(
              fontWeight: FontWeight.bold, fontSize: Get.height * 0.025),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back(closeOverlays: true);
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Align(
        //       alignment: Alignment.centerRight,
        //       child: Icon(
        //         Icons.bookmark_border,
        //         color: Colors.white,
        //         size: Get.height * 0.04,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: blackPrimary,
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.white),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                  'Jika menemukan review yang merupakan spoiler, silahkan dilaporkan dengan menekan tombol lapor',
                                  style: whiteTextFont.copyWith(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned.fill(
                            bottom: 10,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: Get.width * 0.58,
                                height: Get.height * 0.04,
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24))),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            bottom: 18,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: Get.width * 0.58,
                                height: Get.height * 0.04,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24))),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: movieController
                                          .detailMovie.value.posterPath ==
                                      ""
                                  ? Container(
                                      width: Get.width * 0.6,
                                      height: Get.height * 0.5,
                                      child: Center(
                                        child: Text('NO POSTER',
                                            style: whiteTextFont),
                                      ),
                                    )
                                  : Hero(
                                      tag: 'large-poster-' +
                                              movieController.detailMovie.value
                                                  .posterPath ??
                                          "",
                                      child: Container(
                                        width: Get.width * 0.6,
                                        height: Get.height * 0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    baseUrlImageTmdbW500 +
                                                        movieController
                                                            .detailMovie
                                                            .value
                                                            .posterPath),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieController.detailMovie.value.title ?? "",
                              style: whiteTextFont.copyWith(
                                  fontSize: Get.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tanggal Rilis : ' +
                                          movieController
                                              .detailMovie.value.releaseDate ??
                                      '-',
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '|',
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  movieController.detailMovie.value.voteAverage
                                          .toString() ??
                                      "",
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.star,
                                  color: yellowPrimary,
                                  size: Get.height * 0.02,
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Visibility(
                              visible: movieController
                                      .detailMovie.value.genres.length >
                                  0,
                              child: Wrap(
                                children: movieController
                                    .detailMovie.value.genres
                                    .map((e) => Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.0, top: 8),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: RandomColor()
                                                    .randomColor(
                                                        colorBrightness:
                                                            ColorBrightness
                                                                .dark),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              e.name,
                                              style: whiteTextFont.copyWith(
                                                  fontSize: Get.height * 0.015),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Text(
                              'Aktor & Kru',
                              style: whiteTextFont.copyWith(
                                  fontSize: Get.height * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Visibility(
                              visible: movieController
                                      .detailMovie.value.credit.length >
                                  0,
                              child: Container(
                                  width: Get.width,
                                  height: Get.height * 0.15,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movieController
                                          .detailMovie.value.credit.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.2,
                                                    height: Get.height * 0.1,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: movieController
                                                                .detailMovie
                                                                .value
                                                                .credit[i]
                                                                .profilePath !=
                                                            null
                                                        ? Image.network(
                                                            baseUrlImageTmdbW500 +
                                                                movieController
                                                                    .detailMovie
                                                                    .value
                                                                    .credit[i]
                                                                    .profilePath,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : SvgPicture.asset(
                                                            'assets/avatar.svg',
                                                            color: RandomColor()
                                                                .randomColor(
                                                                    colorBrightness:
                                                                        ColorBrightness
                                                                            .light)),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    movieController.detailMovie
                                                        .value.credit[i].name,
                                                    style: whiteTextFont,
                                                  ),
                                                  Text(
                                                    movieController
                                                        .detailMovie
                                                        .value
                                                        .credit[i]
                                                        .character,
                                                    style: yellowTextFont
                                                        .copyWith(fontSize: 8),
                                                  )
                                                ],
                                              ),
                                            ));
                                      })),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Text(
                              'Sinopsis',
                              style: whiteTextFont.copyWith(
                                  fontSize: Get.height * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              movieController.detailMovie.value.overview ?? "",
                              style: whiteTextFont.copyWith(
                                  fontSize: Get.height * 0.015),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Container(
                              width: Get.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: yellowPrimary,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 4),
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    utilsController.fetchProv();
                                    Get.to(AjakNobarPage(
                                        movieController.detailMovie.value));
                                  },
                                  child: Text('AJAK NOBAR',
                                      style: whiteTextFont.copyWith(
                                          fontWeight: FontWeight.bold))),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Review',
                                  style: whiteTextFont.copyWith(
                                      fontSize: Get.height * 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     print('tap');
                                //   },
                                //   child: Row(
                                //     children: [
                                //       Icon(Icons.add, color: yellowPrimary),
                                //       Text(
                                //         'Tambah Review',
                                //         style: yellowTextFont,
                                //       )
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Obx(() => Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Tulis Review',
                                          style: whiteTextFont),
                                      TextField(
                                        // onChanged: (text) {
                                        //   isPasswordValid = text.length >= 6;
                                        // },
                                        style: whiteTextFont.copyWith(
                                            fontSize: Get.height * 0.015),

                                        controller: tReview,
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 4),
                                                textStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              reviewController.sendReview(
                                                  tReview.text,
                                                  movieController
                                                      .detailMovie.value.id
                                                      .toString());
                                            },
                                            child:
                                                reviewController.isLoading.value
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                          backgroundColor:
                                                              yellowPrimary,
                                                          valueColor:
                                                              new AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        )),
                                                      )
                                                    : Text('Kirim',
                                                        style: blackTextFont)),
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Obx(() => reviewController.listReviewMovie.length ==
                                        0 &&
                                    !reviewController.isLoading.value
                                ? Center(
                                    child: Text('Belum ada review',
                                        style: whiteTextFont))
                                : reviewController.listReviewMovie.length > 0 &&
                                        !reviewController.isLoading.value
                                    ? Container(
                                        width: Get.width,
                                        child: Column(
                                          children: reviewController
                                              .listReviewMovie
                                              .map((element) => Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0, bottom: 6),
                                                    child: ReviewCard(element),
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                        backgroundColor: yellowPrimary,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ))),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
