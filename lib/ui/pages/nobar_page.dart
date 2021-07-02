part of 'pages.dart';

class NobarPage extends StatefulWidget {
  @override
  _NobarPageState createState() => _NobarPageState();
}

class _NobarPageState extends State<NobarPage> {
  final nobarController = Get.put(NobarController());

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
                child: Text('NOBAR',
                    style: whiteTextFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.05)),
              ),
              Obx(() => Container(
                    // padding: EdgeInsets.only(left: 24),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: !nobarController.isLoading.value &&
                              nobarController.listMyNobar.length > 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, bottom: 24),
                                child: Text('NOBAR KU',
                                    style: whiteTextFont.copyWith(
                                        fontSize: Get.height * 0.024,
                                        fontWeight: FontWeight.w500)),
                              ),
                              !nobarController.isLoading.value
                                  ? CarouselSlider.builder(
                                      itemCount:
                                          nobarController.listMyNobar.length,
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
                                                nobarController
                                                    .fetchParticipant(
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
                                            // _currentSliderNowPlaying = index;
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              width: Get.width * 0.6,
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.24,
                                          enableInfiniteScroll: false,
                                          viewportFraction: 0.90,
                                          initialPage: 0,
                                          disableCenter: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              // _currentSliderNowPlaying = index;
                                            });
                                          },
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      ),
                                      baseColor: Colors.white60,
                                      highlightColor: Colors.grey[300],
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, bottom: 24, top: 24),
                          child: Text('DAFTAR NOBAR',
                              style: whiteTextFont.copyWith(
                                  fontSize: Get.height * 0.024,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Column(
                            children: nobarController.listNobar
                                .map((element) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 24),
                                      child: GestureDetector(
                                        onTap: () {
                                          nobarController.fetchParticipant(
                                              element.idNobar);
                                          Get.to(DetailNobarPage(element));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: Get.height * 0.1,
                                                  width: Get.width * 0.15,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              baseUrlImageTmdbW500 +
                                                                  element
                                                                      .posterPath),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            element.users
                                                                .namaDepan,
                                                            style: whiteTextFont
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.people,
                                                                  color: Colors
                                                                      .white),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                element
                                                                    .participant
                                                                    .toString(),
                                                                style:
                                                                    whiteTextFont,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                    Get.width *
                                                                        0.15),
                                                        child: Text(
                                                          element.ajakan,
                                                          style: whiteTextFont
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                "d MMMM yyyy",
                                                                "id_ID")
                                                            .format(DateFormat(
                                                                    "yyyy-MM")
                                                                .parse(element
                                                                    .schedule)),
                                                        style: whiteTextFont
                                                            .copyWith(
                                                                color:
                                                                    yellowPrimary,
                                                                fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList())
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
