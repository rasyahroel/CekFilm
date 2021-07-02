part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage(this.registrationData);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  AuthController authController = Get.put(AuthController());

  TextEditingController tEmail = TextEditingController();
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
                          width: Get.width,
                          margin: EdgeInsets.only(top: Get.height * 0.10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'DAFTAR',
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
                        Column(
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
                            Container(
                                width: Get.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: redPrimary,
                                        padding: EdgeInsets.all(12),
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () async {
                                      if (tEmail.text.isEmpty ||
                                          tPassword.text.isEmpty) {
                                        Get.snackbar('Kesalahan',
                                            'Email dan Password tidak boleh kosong',
                                            margin: EdgeInsets.all(12),
                                            backgroundColor: Colors.white70,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      } else {
                                        authController.checkUser(
                                            tEmail.text, tPassword.text);
                                      }
                                    },
                                    child: Text('Daftar'))),
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
                                    authController.loginWithGoogle(
                                        page: SignUpPage(
                                            widget.registrationData));
                                  },
                                )),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: Get.height * 0.1),
                        child: GestureDetector(
                          onTap: () {
                            Get.off(LoginPage(),
                                transition: Transition.upToDown);
                          },
                          child: RichText(
                            text: TextSpan(
                                text: 'Sudah punya akun ? ',
                                style: whiteTextFont.copyWith(
                                    fontSize: Get.height * 0.02,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Masuk',
                                    style: yellowTextFont.copyWith(
                                        fontSize: Get.height * 0.02,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
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
