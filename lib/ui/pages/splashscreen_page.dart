part of 'pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    // Get.put(AuthController()).statusApp();
    final storage = GetStorage();

    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      if (storage.read('isFirstTime') == null) {
        storage.write('isFirstTime', 'true');
        print(storage.read('isFirstTime'));
        Get.offAll(OnBoardingPage());
      } else {
        Get.offAll(Root());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: blackPrimary,
          ),
          SafeArea(
              child: Stack(
            children: [
              Container(
                // width: Get.width,

                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'CEK ',
                            style: whiteTextFont.copyWith(
                                fontSize: Get.height * 0.06,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'FILM',
                                style: redTextFont.copyWith(
                                    fontSize: Get.height * 0.06,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                      Text(
                        'DULU',
                        style: yellowTextFont.copyWith(
                            fontSize: Get.height * 0.02),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
