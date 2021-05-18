part of 'widgets.dart';

class ReviewCard extends StatefulWidget {
  final Review review;
  final Function onTapLike;
  final Function onTapReport;
  ReviewCard(this.review, {this.onTapLike, this.onTapReport});

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(8)),
        width: Get.width,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.review.users.profilePath == ""
                    ? SvgPicture.asset('assets/avatar.svg',
                        width: Get.height * 0.08, color: yellowPrimary)
                    : Image.network(
                        baseUrlImage + widget.review.users.profilePath,
                        width: Get.height * 0.08),
                SizedBox(
                  width: 12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.review.users.namaDepan +
                            ' ' +
                            widget.review.users.namaBelakang,
                        style:
                            whiteTextFont.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '"' + widget.review.review + '"',
                        style: whiteTextFont,
                      )
                      // Row(
                      //   children: [
                      //     Text(movie.voteAverage.toString(),
                      //         style: whiteTextFont),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     Icon(Icons.star, color: Colors.amber)
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                children: [
                  LikeButton(
                    size: Get.height * 0.05,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.thumb_up,
                        color: isLiked ? yellowPrimary : Colors.grey,
                        size: Get.height * 0.02,
                      );
                    },
                    likeCount: int.parse(widget.review.likeCount),
                    countBuilder: (int count, bool isLiked, String text) {
                      var color = isLiked ? Colors.white : Colors.grey;
                      Widget result;
                      if (count == 0) {
                        result = Text(
                          "Suka",
                          style: whiteTextFont.copyWith(fontSize: 12),
                        );
                      } else
                        result = Text(
                          text,
                          style: TextStyle(color: color),
                        );
                      return result;
                    },
                  ),
                  LikeButton(
                    size: Get.height * 0.05,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.flag,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: Get.height * 0.02,
                      );
                    },
                    likeCount: int.parse(widget.review.reportCount),
                    countBuilder: (int count, bool isLiked, String text) {
                      var color = isLiked ? Colors.white : Colors.grey;
                      Widget result;
                      if (count == 0) {
                        result = Text(
                          "Spoiler",
                          style: whiteTextFont.copyWith(fontSize: 12),
                        );
                      } else
                        result = Text(
                          text,
                          style: TextStyle(color: color),
                        );
                      return result;
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}
