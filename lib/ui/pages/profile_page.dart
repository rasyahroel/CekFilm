part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final pref = GetStorage();
  TextEditingController tNewPassword = TextEditingController();
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/pattern_movie.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: pref.read('profilePath') != "" &&
                                pref.read('profilePath') != null
                            ? Image.network(
                                pref.read('profilePath'),
                                fit: BoxFit.fill,
                                height: Get.height * 0.2,
                              )
                            : SvgPicture.asset('assets/avatar.svg',
                                height: Get.height * 0.2,
                                color: RandomColor().randomColor(
                                    colorBrightness: ColorBrightness.light)),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: yellowPrimary,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(GetStorage().read('namaDepan'),
                              style: whiteTextFont)),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.25 -
                  75,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              width: double.infinity,
              color: blackPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          backgroundColor: Colors.white,
                          title: 'Loading...',
                          content: Center(
                              child: SizedBox(
                            height: Get.height * 0.2,
                            child: LottieBuilder.asset('assets/loading.json'),
                          )));
                      authController.getUser(GetStorage().read('idUser'));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.account_circle_outlined,
                            size: 25, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Ubah Profil',
                            style: blackTextFont.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(24),
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(10.0),
                                      topRight: const Radius.circular(10.0))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Masukan kata sandi baru',
                                      style: blackTextFont),
                                  SizedBox(height: 10),
                                  TextField(
                                    // onChanged: (text) {
                                    //   isPasswordValid = text.length >= 6;
                                    // },
                                    style: blackTextFont,
                                    obscureText: true,
                                    controller: tNewPassword,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      width: Get.width,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: yellowPrimary,
                                              padding: EdgeInsets.all(12),
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () async {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());

                                            if (tNewPassword.text.isEmpty) {
                                              Get.back();
                                              Get.snackbar('Kesalahan',
                                                  'Kata sandi tidak boleh kosong',
                                                  margin: EdgeInsets.all(12),
                                                  backgroundColor:
                                                      Colors.white70,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                            } else {
                                              Get.back();

                                              Get.defaultDialog(
                                                  backgroundColor: Colors.white,
                                                  title: 'Loading...',
                                                  content: Center(
                                                      child: SizedBox(
                                                    height: Get.height * 0.2,
                                                    child: LottieBuilder.asset(
                                                        'assets/loading.json'),
                                                  )));
                                              authController.changePassword(
                                                  tNewPassword.text);
                                            }
                                          },
                                          child: Text('Ubah Kata Sandi'))),
                                ],
                              ),
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.lock, size: 25, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Ganti Password',
                            style: blackTextFont.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  GestureDetector(
                    onTap: () async {
                      authController.logout();

                      // Get.offAll(LoginPage());
                      // await Get.put(AuthController()).deletePlayerId();
                      // pref.write('isLogin', false);
                      // pref.write('role', null);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 25, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Keluar',
                            style: blackTextFont.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
