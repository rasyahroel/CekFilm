part of 'pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pref = GetStorage();
  int _currentSliderNowPlaying = 0;
  TextEditingController tSearch = TextEditingController();

  MovieController movieController = Get.put(MovieController());
  NobarController nobarController = Get.put(NobarController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 400));
    movieController.fetchNowPlaying();
    movieController.fetchRamaiReview();
    nobarController.fetchNobarList();
    nobarController.fetchMyNobarList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackPrimary,
        body: SafeArea(
            child: RefreshWidget(
          onRefresh: refresh,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: Get.width / 1.5,
                              child: Text(
                                'Hello,' + pref.read('namaDepan'),
                                style: whiteTextFont.copyWith(
                                    fontSize: Get.height * 0.025,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        pref.read('profilePath') == null ||
                                pref.read('profilePath') == ""
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(MainPage(
                                    bottomNavBarIndex: 3,
                                  ));
                                },
                                child: SvgPicture.asset('assets/avatar.svg',
                                    width: Get.height * 0.07,
                                    color: yellowPrimary),
                              )
                            : Image.network(
                                baseUrlImage + pref.read('profilePath'),
                                width: Get.height * 0.07,
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(SearchMoviePage());
                        },
                        child: TextField(
                          // onChanged: (text) {
                          //   isPasswordValid = text.length >= 6;
                          // },
                          onSubmitted: (value) {
                            Get.to(SearchMoviePage());
                          },
                          style: whiteTextFont,
                          controller: tSearch,
                          enabled: false,

                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white),
                              labelStyle: whiteTextFont,
                              hintText: "Cari....",
                              hintStyle: whiteTextFont,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, bottom: 24),
                          child: Text('Sedang Tayang',
                              style: whiteTextFont.copyWith(
                                  fontSize: Get.height * 0.024,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Obx(() {
                          return !movieController.isLoading.value
                              ? Container(
                                  height: Get.height * 0.4,
                                  child: ListView.builder(
                                      itemCount:
                                          movieController.listNowPlaying.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          width: Get.width * 0.5,
                                          margin: EdgeInsets.only(
                                              left: (index == 0) ? 24 : 0,
                                              right: (index ==
                                                      movieController
                                                              .listNowPlaying
                                                              .length -
                                                          1)
                                                  ? defaultMargin
                                                  : 16),
                                          child: LargePosterCard(
                                            movieController
                                                .listNowPlaying[index]
                                                .posterPath,
                                            onTap: () {
                                              movieController.fetchDetailMovie(
                                                  movieController
                                                      .listNowPlaying[index].id
                                                      .toString(),
                                                  isNowPlaying: true);
                                              print(movieController
                                                  .listNowPlaying[index].id);
                                            },
                                          ),
                                        );
                                      }),
                                )
                              : Shimmer.fromColors(
                                  child: CarouselSlider.builder(
                                    itemCount: 3,
                                    itemBuilder: (context, index, relIdx) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: (index == 0) ? 0 : 0,
                                            right: (index == 3 - 1)
                                                ? defaultMargin
                                                : 16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white10,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          height: Get.height * 0.3,
                                          width: Get.width * 0.2,
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: Get.height * 0.4,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 0.60,
                                      disableCenter: true,
                                      enlargeCenterPage: true,
                                      initialPage: 0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentSliderNowPlaying = index;
                                        });
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  baseColor: Colors.white60,
                                  highlightColor: Colors.grey[300],
                                );
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: !nobarController.isLoading.value &&
                              nobarController.listNobar.length == 0
                          ? false
                          : true,
                      child: Container(
                        // padding: EdgeInsets.only(left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, bottom: 24),
                              child: Text('Nobar',
                                  style: whiteTextFont.copyWith(
                                      fontSize: Get.height * 0.024,
                                      fontWeight: FontWeight.w500)),
                            ),
                            !nobarController.isLoading.value
                                ? CarouselSlider.builder(
                                    itemCount:
                                        nobarController.listNobar.length > 10
                                            ? nobarController.listNobar
                                                .sublist(0, 10)
                                            : nobarController.listNobar.length,
                                    itemBuilder: (context, index, realIdx) {
                                      return Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0) ? 0 : 0,
                                              right: (index == 3 - 1)
                                                  ? defaultMargin
                                                  : 16),
                                          child: NobarCard(
                                            nobarController.listNobar[index],
                                            onTap: () {
                                              nobarController.fetchParticipant(
                                                  nobarController
                                                      .listNobar[index]
                                                      .idNobar);

                                              Get.to(DetailNobarPage(
                                                  nobarController
                                                      .listNobar[index]));
                                            },
                                          ));
                                    },
                                    options: CarouselOptions(
                                      height: Get.height * 0.24,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 0.90,
                                      disableCenter: true,
                                      initialPage: 0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentSliderNowPlaying = index;
                                        });
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  )
                                : Shimmer.fromColors(
                                    child: CarouselSlider.builder(
                                      itemCount: 3,
                                      itemBuilder: (context, index, relIdx) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: (index == 0) ? 0 : 0,
                                              right: (index == 3 - 1)
                                                  ? defaultMargin
                                                  : 16),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white10,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            width: Get.width * 0.6,
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.24,
                                        enableInfiniteScroll: false,
                                        viewportFraction: 0.90,
                                        initialPage: 0,
                                        disableCenter: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _currentSliderNowPlaying = index;
                                          });
                                        },
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                    baseColor: Colors.white60,
                                    highlightColor: Colors.grey[300],
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => Visibility(
                      visible: !movieController.isLoading.value &&
                              movieController.listRamaiReview.length == 0
                          ? false
                          : true,
                      child: Container(
                        // padding: EdgeInsets.only(left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, bottom: 24),
                              child: Text('Ramai di review',
                                  style: whiteTextFont.copyWith(
                                      fontSize: Get.height * 0.024,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              child: Column(
                                children: movieController
                                            .listRamaiReview.length <=
                                        10
                                    ? movieController.listRamaiReview
                                        .map((element) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 24),
                                          child: WidthMovieCard(
                                            element,
                                            onTap: () {
                                              print(element.id.toString());
                                              movieController.fetchDetailMovie(
                                                  element.id.toString());
                                            },
                                          ),
                                        );
                                      }).toList()
                                    : movieController.listRamaiReview
                                        .sublist(0, 10)
                                        .map((element) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 24),
                                          child: WidthMovieCard(
                                            element,
                                            onTap: () {
                                              print(element.id.toString());
                                              movieController.fetchDetailMovie(
                                                  element.id.toString());
                                            },
                                          ),
                                        );
                                      }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
