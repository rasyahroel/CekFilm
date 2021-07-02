part of 'pages.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final pref = GetStorage();
  PageController _pageController = PageController();
  List<Map<String, String>> onBoardData = [
    {
      'content_1': "Suka bingung mau nonton apa ?",
      'content_2': "Cari referensi dengan review film disini dan anti spoiler",
      'image': 'assets/ilus_welcome_1.png'
    },
    {
      'content_1': "Bosan nonton sendirian ?",
      'content_2': "Temukan teman nobar kamu disini dengan fitur NOBAR",
      'image': 'assets/ilus_welcome_2.png'
    },
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: onBoardData.length,
                    itemBuilder: (context, index) => OnBoardingContent(
                          image: onBoardData[index]['image'],
                          content1: onBoardData[index]['content_1'],
                          content2: onBoardData[index]['content_2'],
                        )),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      currentPage != 0
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pageController.previousPage(
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.linear);
                                });
                              },
                              child: Row(children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: yellowPrimary,
                                ),
                                Text(
                                  'Kembali',
                                  style: yellowTextFont.copyWith(fontSize: 12),
                                )
                              ]),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(onBoardData.length,
                            (index) => buildDots(index: index)),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (currentPage == 1) {
                            // if (pref.read('statusApp') == 'unrelease') {
                            //   Get.offAll(IlustrationPage(
                            //       title: 'PERUMDAM PASBAR belum bisa digunakan',
                            //       subtitle: pref.read('keteranganStatus'),
                            //       picturePath: 'assets/ilus_service.png'));
                            // } else {
                            Get.offAll(Root());
                            // }
                          } else {
                            setState(() {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.linear);
                            });
                          }
                        },
                        child: Row(children: [
                          Text(currentPage == 1 ? 'Mulai' : 'Lanjut',
                              style: yellowTextFont.copyWith(fontSize: 12)),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: yellowPrimary,
                          ),
                        ]),
                      ),
                      // SizedBox(height: 20),
                      // OnBoardButton(
                      //     text: 'Mulai',
                      //     onPress: () {
                      //       Get.to(LoginPage());
                      //     }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDots({int index}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? yellowPrimary : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnBoardButton extends StatelessWidget {
  const OnBoardButton({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FlatButton(
        child: Text(
          text,
          style: whiteTextFont.copyWith(fontWeight: FontWeight.w800),
        ),
        onPressed: onPress,
        color: yellowPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    Key key,
    this.content1,
    this.content2,
    this.image,
  }) : super(key: key);

  final String content1;
  final String content2;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 24, vertical: Get.height * 0.05),
            child: SizedBox(
              width: Get.width / 1,
              child: Text(
                content1,
                style: whiteTextFont.copyWith(
                    fontSize: Get.height * 0.03, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        //   child: SizedBox(
        //     width: double.infinity,
        //     child: Text(
        //       content2,
        //       style: blackTextFont.copyWith(
        //           fontSize: 14, fontWeight: FontWeight.w500),
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // ),

        Expanded(
          flex: 2,
          child: Image.asset(
            image,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ),

        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 14, vertical: Get.height * 0.08),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                content2,
                style: yellowTextFont.copyWith(
                    fontSize: Get.height * 0.02, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        // Spacer(
        //   flex: 2,
        // ),
      ],
    );
  }
}
