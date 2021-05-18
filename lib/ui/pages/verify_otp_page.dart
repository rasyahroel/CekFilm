part of 'pages.dart';

class OtpVerificationPage extends StatefulWidget {
  final RegistrationData registrationData;
  OtpVerificationPage(this.registrationData);
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";
  final AuthController authController = Get.put(AuthController());
  bool isWaitToResend = false;
  bool hasError = false;
  String currentText = "";
  String otp = "";
  StreamController<ErrorAnimationType> errorController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    listenOtp();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  _onKeyboardTap(String value) {
    // setState(() {
    //   if (textEditingController.text.length <= 5) {
    //     textEditingController.text = textEditingController.text + value;
    //     if (textEditingController.text.length == 6) {
    //       if (int.tryParse(textEditingController.text) == int.tryParse(otp)) {
    //         print('match');
    //       } else {
    //         print('not_match');
    //       }
    //       // if (widget.otpNumber == int.tryParse(textEditingController.text)) {
    //       //   authController.createUser(widget.registrationData);
    //       // } else {
    //       //   Get.snackbar('OTP Salah', 'Kode OTP yang kamu masukan salah',
    //       //       margin: EdgeInsets.all(12),
    //       //       backgroundColor: Colors.white70,
    //       //       snackPosition: SnackPosition.BOTTOM);
    //       // }
    //     }
    //   }
    // });
    if (textEditingController.text.length <= 5) {
      textEditingController.text = textEditingController.text + value;
      // if (textEditingController.text.length == 6) {
      //   if (int.tryParse(textEditingController.text) == int.tryParse(otp)) {
      //     print('match');
      //   } else {
      //     print('not_match');
      //   }
      //   // if (widget.otpNumber == int.tryParse(textEditingController.text)) {
      //   //   authController.createUser(widget.registrationData);
      //   // } else {
      //   //   Get.snackbar('OTP Salah', 'Kode OTP yang kamu masukan salah',
      //   //       margin: EdgeInsets.all(12),
      //   //       backgroundColor: Colors.white70,
      //   //       snackPosition: SnackPosition.BOTTOM);
      //   // }
      // }
    }
  }

  void listenOtp() async {
    await SmsAutoFill().listenForCode;

    // if (int.tryParse(textEditingController.text) == int.tryParse(otp)) {
    //   print('match');
    // } else {
    //   print('not_match');
    // }
    // if (widget.otpNumber == int.tryParse(textEditingController.text)) {
    //   authController.createUser(widget.registrationData);
    // } else {
    //   Get.snackbar('OTP Salah', 'Kode OTP yang kamu masukan salah',
    //       margin: EdgeInsets.all(12),
    //       backgroundColor: Colors.white70,
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackPrimary,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      backgroundColor: blackPrimary,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Container(
              color: blackPrimary,
              // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Text(
                    'Verifikasi OTP',
                    textAlign: TextAlign.center,
                    style: blackTextFont.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 24, horizontal: Get.width * 0.2),
                        child: PinFieldAutoFill(
                          codeLength: 6,
                          onCodeSubmitted: (val) {
                            print('submit ' + val);
                          },

                          currentCode: textEditingController.text,
                          decoration: UnderlineDecoration(
                            textStyle: whiteTextFont,
                            colorBuilder: PinListenColorBuilder(
                                Colors.white, yellowPrimary),
                          ),

                          // keyboardType: TextInputType.,
                          controller: textEditingController,

                          onCodeChanged: (val) {
                            print(val);
                            print(otp);
                            if (otp == "") {
                              setState(() {
                                otp = val;
                                if (otp != "") {
                                  Get.defaultDialog(
                                      backgroundColor: Colors.white,
                                      title: 'Loading...',
                                      content: Center(
                                          child: SizedBox(
                                        height: Get.height * 0.2,
                                        child: LottieBuilder.asset(
                                            'assets/loading.json'),
                                      )));
                                  authController
                                      .createUser(widget.registrationData);
                                }
                              });
                            } else if (val.length == 6 &&
                                int.tryParse(textEditingController.text) ==
                                    int.tryParse(otp)) {
                              Get.defaultDialog(
                                  backgroundColor: Colors.white,
                                  title: 'Loading...',
                                  content: Center(
                                      child: SizedBox(
                                    height: Get.height * 0.2,
                                    child: LottieBuilder.asset(
                                        'assets/loading.json'),
                                  )));
                              authController
                                  .createUser(widget.registrationData);
                            } else if (val.length == 6 &&
                                int.tryParse(textEditingController.text) !=
                                    int.tryParse(otp)) {
                              Get.snackbar('Otp Salah',
                                  'Kode OTP yang kamum masukan salah',
                                  margin: EdgeInsets.all(12),
                                  backgroundColor: Colors.white70,
                                  snackPosition: SnackPosition.TOP);
                            } else {
                              print(val);
                            }
                          },
                        )
                        //     PinCodeTextField(
                        //   textStyle: whiteTextFont,
                        //   backgroundColor: blackPrimary,
                        //   appContext: context,

                        //   pastedTextStyle: TextStyle(
                        //     // color: Colors.green.shade600,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   length: 6,
                        //   obscureText: false,
                        //   // obscuringWidget: Icon(
                        //   //   Icons.circle,
                        //   //   color: Colors.white,
                        //   //   size: 15,
                        //   // ),
                        //   // obscuringCharacter: '*',
                        //   // blinkWhenObscuring: true,
                        //   animationType: AnimationType.fade,
                        //   // validator: (v) {
                        //   //   if (v.length < 3) {
                        //   //     return "I'm from validator";
                        //   //   } else {
                        //   //     return null;
                        //   //   }
                        //   // },
                        //   pinTheme: PinTheme(
                        //     shape: PinCodeFieldShape.circle,
                        //     borderRadius: BorderRadius.circular(5),
                        //     fieldHeight: 40,
                        //     disabledColor: Colors.transparent,
                        //     inactiveColor: yellowPrimary,
                        //     selectedFillColor: Colors.transparent,
                        //     fieldWidth: 20,
                        //     selectedColor: Colors.transparent,
                        //     inactiveFillColor: blackPrimary,
                        //     activeColor: Colors.transparent,
                        //     activeFillColor: Colors.transparent,
                        //   ),
                        //   // cursorColor: Colors.black,
                        //   animationDuration: Duration(milliseconds: 300),

                        //   // backgroundColor: Colors.blue.shade50,
                        //   // enableActiveFill: true,
                        //   errorAnimationController: errorController,
                        //   controller: textEditingController,
                        //   keyboardType: TextInputType.number,
                        //   // boxShadows: [
                        //   //   BoxShadow(
                        //   //     offset: Offset(1, 1),
                        //   //     color: Colors.black12,
                        //   //     blurRadius: 10,
                        //   //   )
                        //   // ],
                        //   onCompleted: (v) {},
                        //   // onTap: () {
                        //   //   print("Pressed");
                        //   // },
                        //   onChanged: (value) {
                        //     setState(() {
                        //       currentText = value;
                        //       print(currentText);
                        //     });
                        //   },
                        //   // beforeTextPaste: (text) {
                        //   //   print("Allowing to paste $text");
                        //   //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //   //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        //   //   return true;
                        //   // },
                        // ),
                        ),
                  ),
                  !isWaitToResend
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Tidak mendapatkan sms ?',
                              textAlign: TextAlign.center,
                              style: blackTextFont.copyWith(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w100,
                                  fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   isWaitToResend = !isWaitToResend;
                                // });
                              },
                              child: Text('Kirim ulang',
                                  style: whiteTextFont.copyWith(
                                      color: yellowPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              width: Get.width,
              child: NumericKeyboard(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onKeyboardTap: _onKeyboardTap,
                textColor: Colors.white,
                rightButtonFn: () {
                  setState(() {
                    textEditingController.text = textEditingController.text
                        .substring(0, textEditingController.text.length - 1);
                  });
                },
                rightIcon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
