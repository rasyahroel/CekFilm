part of 'widgets.dart';

class NobarCard extends StatelessWidget {
  final Nobar nobar;
  final Function onTap;
  NobarCard(this.nobar, {this.onTap});

  @override
  Widget build(BuildContext context) {
    RandomColor _randomColor = RandomColor();
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          width: Get.width * 0.6,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    baseUrlImageTmdbW500 + nobar.posterPath),
                                fit: BoxFit.cover)),
                      )),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Get.height * 0.15, right: 8, top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  nobar.users.namaDepan,
                                  style: whiteTextFont.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.people, color: Colors.white),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      nobar.participant.toString(),
                                      style: whiteTextFont,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: Get.width * 0.15),
                              child: Text(
                                nobar.ajakan,
                                style: whiteTextFont.copyWith(
                                    fontSize: 12, fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Selasa,2 Mei 2021',
                              style: whiteTextFont.copyWith(
                                  color: yellowPrimary, fontSize: 12),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              Positioned(
                  bottom: Get.height * 0.055,
                  left: Get.width * 0.02,
                  child: Column(
                    children: [
                      nobar.posterPath == null
                          ? SvgPicture.asset('assets/avatar.svg',
                              width: Get.height * 0.1, color: yellowPrimary)
                          : Image.network(
                              baseUrlImageTmdbW500 + nobar.posterPath,
                              width: Get.height * 0.1),
                      SizedBox(
                        height: 2,
                      ),
                      nobar.freeTicket == "1"
                          ? Container(
                              child: Text(
                                'Gratis Tiket',
                                style: whiteTextFont.copyWith(fontSize: 10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: _randomColor.randomColor(
                                      colorBrightness: ColorBrightness.dark)),
                            )
                          : SizedBox()
                    ],
                  )),
              Positioned(
                  right: 10,
                  top: 5,
                  child: Container(
                    child: Text(
                      nobar.title,
                      style: whiteTextFont,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: _randomColor.randomColor(
                            colorBrightness: ColorBrightness.dark)),
                  )),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Row(
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
                        nobar.namaKab,
                        style: whiteTextFont.copyWith(
                            fontSize: Get.height * 0.015),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
