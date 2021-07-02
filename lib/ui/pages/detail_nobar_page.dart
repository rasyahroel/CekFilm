part of 'pages.dart';

class DetailNobarPage extends StatefulWidget {
  final Nobar nobar;
  DetailNobarPage(this.nobar);
  @override
  _DetailNobarPageState createState() => _DetailNobarPageState();
}

class _DetailNobarPageState extends State<DetailNobarPage> {
  final nobarController = Get.put(NobarController());
  final pref = GetStorage();
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: blackPrimary,
          appBar: AppBar(
            backgroundColor: Colors.black12,
            shadowColor: Colors.transparent,
            title: Text(
              'Nobar',
              style: whiteTextFont.copyWith(
                  fontWeight: FontWeight.bold, fontSize: Get.height * 0.025),
            ),
            leading: GestureDetector(
                onTap: () {
                  nobarController.isJoin.value = false;
                  Get.back(closeOverlays: true);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          body: Stack(
            children: [
              SafeArea(
                  child: ListView(
                children: [
                  nobarController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                          backgroundColor: yellowPrimary,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        ))
                      : Container(
                          margin: widget.nobar.userId != pref.read('idUser') &&
                                  nobarController.listParticipant
                                          .where((e) =>
                                              e.user.idUser ==
                                              pref.read('idUser'))
                                          .length >
                                      0
                              ? EdgeInsets.only(top: Get.height * 0.08)
                              : null,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: widget.nobar.posterPath == ""
                                            ? Container(
                                                color: Colors.grey,
                                                width: Get.width * 0.12,
                                                height: Get.height * 0.10,
                                                child: Center(
                                                  child: Text(
                                                    'NO POSTER',
                                                    style:
                                                        whiteTextFont.copyWith(
                                                            fontSize:
                                                                Get.height *
                                                                    0.008),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: Get.width * 0.1,
                                                height: Get.height * 0.15,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            baseUrlImageTmdbW500 +
                                                                widget.nobar
                                                                    .posterPath),
                                                        fit: BoxFit.fill)),
                                              ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.5,
                                                  child: Text(
                                                      widget.nobar.title,
                                                      style: whiteTextFont),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    widget.nobar.users.profilePath == null ||
                                            widget.nobar.users.profilePath == ""
                                        ? SvgPicture.asset('assets/avatar.svg',
                                            width: Get.height * 0.1,
                                            color: yellowPrimary)
                                        : Image.network(
                                            baseUrlImage +
                                                widget.nobar.users.profilePath,
                                            width: Get.height * 0.1),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.nobar.users.namaDepan,
                                            style: whiteTextFont),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.place_outlined,
                                              color: Colors.white,
                                              size: Get.height * 0.02,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              widget.nobar.namaKab,
                                              style: whiteTextFont.copyWith(
                                                  fontSize: Get.height * 0.015),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('"' + widget.nobar.ajakan + '"',
                                    style: whiteTextFont),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Jadwal Nobar :',
                                    style: whiteTextFont.copyWith(
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    DateFormat("EEEE dd MMMM yyyy", "id_ID")
                                        .format(DateFormat("yyyy-MM")
                                            .parse(widget.nobar.schedule)),
                                    style: whiteTextFont.copyWith(
                                        fontSize: Get.height * 0.015)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Maksimal teman nobar :',
                                    style: whiteTextFont.copyWith(
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.nobar.maxPerson + ' Orang',
                                    style: whiteTextFont.copyWith(
                                        fontSize: Get.height * 0.015)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Ditraktir tiket :',
                                    style: whiteTextFont.copyWith(
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    widget.nobar.freeTicket == '1'
                                        ? 'Iya'
                                        : 'Tidak',
                                    style: whiteTextFont.copyWith(
                                        fontSize: Get.height * 0.015)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Partisipan : ' +
                                          nobarController.listParticipant.length
                                              .toString() ??
                                      '0',
                                  style: whiteTextFont.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Visibility(
                                  visible: !nobarController.isLoading.value &&
                                      nobarController.listParticipant.length >
                                          0,
                                  child: Container(
                                    width: Get.width,
                                    height: Get.height * 0.15,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: nobarController
                                          .listParticipant.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        builder: (context) {
                                                          return Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    24),
                                                            decoration: new BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: new BorderRadius
                                                                        .only(
                                                                    topLeft: const Radius
                                                                            .circular(
                                                                        10.0),
                                                                    topRight: const Radius
                                                                            .circular(
                                                                        10.0))),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    'Participant',
                                                                    style:
                                                                        blackTextFont),
                                                                SizedBox(
                                                                    height: 10),
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.2,
                                                                  height:
                                                                      Get.height *
                                                                          0.1,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20))),
                                                                  child: nobarController
                                                                              .listParticipant[
                                                                                  i]
                                                                              .user
                                                                              .profilePath !=
                                                                          ""
                                                                      ? Image
                                                                          .network(
                                                                          baseUrlImage +
                                                                              nobarController.listParticipant[i].user.profilePath,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        )
                                                                      : SvgPicture.asset(
                                                                          'assets/avatar.svg',
                                                                          color:
                                                                              RandomColor().randomColor(colorBrightness: ColorBrightness.light)),
                                                                ),
                                                                SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Text(
                                                                  nobarController
                                                                      .listParticipant[
                                                                          i]
                                                                      .user
                                                                      .namaDepan,
                                                                  style:
                                                                      blackTextFont,
                                                                ),
                                                                SizedBox(
                                                                    height: 2),
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            yellowPrimary,
                                                                        padding: EdgeInsets.all(
                                                                            12),
                                                                        textStyle: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold)),
                                                                    onPressed:
                                                                        () async {
                                                                      Get.back();

                                                                      Get.defaultDialog(
                                                                          backgroundColor: Colors.white,
                                                                          title: 'Loading...',
                                                                          content: Center(
                                                                              child: SizedBox(
                                                                            height:
                                                                                Get.height * 0.2,
                                                                            child:
                                                                                LottieBuilder.asset('assets/loading.json'),
                                                                          )));
                                                                      nobarController.accNobar(
                                                                          nobarController
                                                                              .listParticipant[
                                                                                  i]
                                                                              .user
                                                                              .idUser,
                                                                          widget
                                                                              .nobar
                                                                              .idNobar);
                                                                    },
                                                                    child: Text(
                                                                        'Terima'))
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    width: Get.width * 0.2,
                                                    height: Get.height * 0.1,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: nobarController
                                                                .listParticipant[
                                                                    i]
                                                                .user
                                                                .profilePath !=
                                                            ""
                                                        ? Image.network(
                                                            baseUrlImage +
                                                                nobarController
                                                                    .listParticipant[
                                                                        i]
                                                                    .user
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
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  nobarController
                                                      .listParticipant[i]
                                                      .user
                                                      .namaDepan,
                                                  style: whiteTextFont,
                                                ),
                                                SizedBox(height: 2),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                widget.nobar.userId == pref.read('idUser')
                                    ? Column(
                                        children: [
                                          Container(
                                              width: Get.width,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.white,
                                                          padding: EdgeInsets
                                                              .all(12),
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    Get.defaultDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        title: 'Loading...',
                                                        content: Center(
                                                            child: SizedBox(
                                                          height:
                                                              Get.height * 0.2,
                                                          child: LottieBuilder
                                                              .asset(
                                                                  'assets/loading.json'),
                                                        )));
                                                    nobarController
                                                        .selesaiNobar(widget
                                                            .nobar.idNobar);
                                                  },
                                                  child: Text('Selesai',
                                                      style: blackTextFont
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)))),
                                          Container(
                                              width: Get.width,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: redPrimary,
                                                          padding: EdgeInsets
                                                              .all(12),
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    Get.defaultDialog(
                                                        backgroundColor:
                                                            Colors.white,
                                                        title: 'Loading...',
                                                        content: Center(
                                                            child: SizedBox(
                                                          height:
                                                              Get.height * 0.2,
                                                          child: LottieBuilder
                                                              .asset(
                                                                  'assets/loading.json'),
                                                        )));
                                                    nobarController
                                                        .batalkanNobar(widget
                                                            .nobar.idNobar);
                                                  },
                                                  child: Text('Batalkan Nobar',
                                                      style: whiteTextFont
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))))
                                        ],
                                      )
                                    : SizedBox(),
                                nobarController.listParticipant
                                            .where((e) =>
                                                e.user.idUser ==
                                                    pref.read('idUser') &&
                                                e.sParticipant == '1')
                                            .length >
                                        0
                                    ? Container(
                                        width: Get.width,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green[600],
                                                padding: EdgeInsets.all(12),
                                                textStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              Get.defaultDialog(
                                                  backgroundColor: Colors.white,
                                                  title: 'Loading...',
                                                  content: Center(
                                                      child: SizedBox(
                                                    height: Get.height * 0.2,
                                                    child: LottieBuilder.asset(
                                                        'assets/loading.json'),
                                                  )));
                                              nobarController.chatWa(
                                                  widget.nobar.users.noHp);
                                            },
                                            child: Text('Hubungi via Whatsapp',
                                                style: whiteTextFont.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold))))
                                    : SizedBox(),
                                SizedBox(height: 20)

                                // ],
                              ]),
                        )
                ],
              )),
              Visibility(
                visible: widget.nobar.sNobar == '1' &&
                    widget.nobar.userId != pref.read('idUser') &&
                    nobarController.listParticipant
                            .where((e) => e.user.idUser == pref.read('idUser'))
                            .length ==
                        0 &&
                    !nobarController.isJoin.value,
                child: Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                      width: Get.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: yellowPrimary,
                              padding: EdgeInsets.all(12),
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            Get.defaultDialog(
                                backgroundColor: Colors.white,
                                title: 'Loading...',
                                content: Center(
                                    child: SizedBox(
                                  height: Get.height * 0.2,
                                  child: LottieBuilder.asset(
                                      'assets/loading.json'),
                                )));
                            nobarController.joinNobar(widget.nobar.idNobar);
                          },
                          child: Text('Ikut Nobar'))),
                ),
              ),
              widget.nobar.userId != pref.read('idUser') &&
                      nobarController.listParticipant
                              .where(
                                  (e) => e.user.idUser == pref.read('idUser'))
                              .length >
                          0
                  ? Positioned(
                      top: 0,
                      child: Container(
                        color: nobarController.listParticipant
                                    .where((e) =>
                                        e.user.idUser == pref.read('idUser') &&
                                        e.sParticipant == '0')
                                    .length >
                                0
                            ? Colors.yellow[700]
                            : Colors.green[300],
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, color: Colors.white),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                  nobarController.listParticipant.where((e) =>
                                              e.user.idUser ==
                                                  pref.read('idUser') &&
                                              e.sParticipant == '0') !=
                                          null
                                      ? 'Sedang menunggu konfirmasi dari yang ngajak nobar'
                                      : 'Yeay ! Kamu telah dipilih oleh pembuat nobar untuk ikut nobar, silahkan hubungi dengan tombol di bawah',
                                  style: whiteTextFont.copyWith(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ));
  }
}
