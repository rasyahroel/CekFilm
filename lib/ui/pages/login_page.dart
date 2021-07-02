part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  AuthController authController = Get.find();

  TextEditingController tEmail = TextEditingController();
  TextEditingController tEmailReset = TextEditingController();
  TextEditingController tPassword = TextEditingController();
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            children: [
              Container(
                height: Get.height,
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.10),
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'MASUK',
                                style: whiteTextFont.copyWith(
                                    fontSize: Get.height * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'DULU',
                                style: yellowTextFont,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                // onChanged: (text) {
                                //   isPasswordValid = text.length >= 6;
                                // },
                                style: whiteTextFont,
                                controller: tEmail,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: whiteTextFont,
                                    hintText: "Masukkan email anda",
                                    hintStyle: whiteTextFont,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                // onChanged: (text) {
                                //   isPasswordValid = text.length >= 6;
                                // },
                                style: whiteTextFont,

                                controller: tPassword,
                                obscureText: isHide,
                                decoration: InputDecoration(
                                    labelText: 'Kata Sandi',
                                    labelStyle: whiteTextFont,
                                    hintStyle: whiteTextFont,
                                    hintText: "Masukkan Kata Sandi Anda",
                                    suffixIcon: IconButton(
                                        icon: isHide
                                            ? Icon(Icons.visibility_off,
                                                color: Colors.white)
                                            : Icon(Icons.visibility,
                                                color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            isHide = !isHide;
                                          });
                                        }),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return Container(
                                              padding: EdgeInsets.all(24),
                                              decoration: new BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      new BorderRadius.only(
                                                          topLeft: const Radius
                                                              .circular(10.0),
                                                          topRight: const Radius
                                                              .circular(10.0))),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                      'Masukan email saat anda mendaftarkan akun di aplikasi ini',
                                                      style: blackTextFont),
                                                  SizedBox(height: 10),
                                                  TextField(
                                                    // onChanged: (text) {
                                                    //   isPasswordValid = text.length >= 6;
                                                    // },
                                                    style: blackTextFont,

                                                    controller: tEmailReset,
                                                    decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10.0)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10.0)),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black),
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
                                                              primary:
                                                                  yellowPrimary,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(12),
                                                              textStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          onPressed: () async {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());

                                                            if (tEmailReset
                                                                .text.isEmpty) {
                                                              Get.snackbar(
                                                                  'Kesalahan',
                                                                  'Email dan Password tidak boleh kosong',
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              12),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white70,
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM);
                                                            } else {
                                                              Get.back();

                                                              Get.defaultDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  title:
                                                                      'Loading...',
                                                                  content:
                                                                      Center(
                                                                          child:
                                                                              SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.2,
                                                                    child: LottieBuilder
                                                                        .asset(
                                                                            'assets/loading.json'),
                                                                  )));
                                                              authController
                                                                  .resetPassword(
                                                                      tEmailReset
                                                                          .text);
                                                            }
                                                          },
                                                          child: Text(
                                                              'Kirim Email Verifikasi'))),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Text('Lupa Password ?',
                                        style: yellowTextFont),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: Get.width,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: redPrimary,
                                          padding: EdgeInsets.all(12),
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                                        if (tEmail.text.isEmpty ||
                                            tPassword.text.isEmpty) {
                                          Get.back();
                                          Get.snackbar('Kesalahan',
                                              'Email dan Password tidak boleh kosong',
                                              margin: EdgeInsets.all(12),
                                              backgroundColor: Colors.white70,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        } else {
                                          authController.login(
                                              tEmail.text, tPassword.text);
                                        }
                                      },
                                      child: Text('Masuk'))),
                              Container(
                                  width: Get.width,
                                  child: SignInButton(
                                    Buttons.Google,
                                    padding: EdgeInsets.all(2),
                                    text: "Masuk dengan google",
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
                                      authController.loginWithGoogle();
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.1),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(SignUpPage(RegistrationData()),
                                transition: Transition.downToUp);
                          },
                          child: RichText(
                            text: TextSpan(
                                text: 'Belum punya akun ? ',
                                style: whiteTextFont.copyWith(
                                    fontSize: Get.height * 0.02,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Daftar dulu',
                                    style: yellowTextFont.copyWith(
                                        fontSize: Get.height * 0.02,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
