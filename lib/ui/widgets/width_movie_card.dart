part of 'widgets.dart';

class WidthMovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  WidthMovieCard(this.movie, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          width: Get.width * 0.6,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width * 0.12,
                    height: Get.height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                baseUrlImageTmdbW500 + movie.posterPath))),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: whiteTextFont.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(movie.voteAverage.toString(),
                                style: whiteTextFont),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.star, color: Colors.amber)
                          ],
                        )
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
                        Icons.comment,
                        color: Colors.white,
                        size: Get.height * 0.02,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        movie.jumlahReview.toString(),
                        style: whiteTextFont,
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
