part of 'widgets.dart';

class LargePosterCard extends StatelessWidget {
  final String image;
  final Function onTap;
  LargePosterCard(this.image, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Hero(
        tag: 'large-poster-' + image,
        child: Container(
          height: Get.height * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.3),
              //     spreadRadius: 2,
              //     blurRadius: 1,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
              image: DecorationImage(
                  image: NetworkImage(baseUrlImageTmdbW500 + image),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
