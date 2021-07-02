part of 'pages.dart';

class RegistrationDataPage extends StatefulWidget {
  final RegistrationData registrationData;

  RegistrationDataPage(this.registrationData);
  @override
  _RegistrationDataPageState createState() => _RegistrationDataPageState();
}

class _RegistrationDataPageState extends State<RegistrationDataPage> {
  TextEditingController tNamaDepan = TextEditingController();
  TextEditingController tNamaBelakang = TextEditingController();
  TextEditingController tNope = TextEditingController();
  String nope = '';
  String initialCountry = 'ID';
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  UtilsController utilsController = Get.put(UtilsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      appBar: AppBar(
        backgroundColor: blackPrimary,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Get.put(AuthController().logout());

              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            height: Get.height,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kenalan lebih dekat yuk !',
                  style: whiteTextFont.copyWith(
                      fontSize: Get.height * 0.03, fontWeight: FontWeight.bold),
                ),
                Expanded(
                    flex: 3,
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
                          keyboardType: TextInputType.name,

                          controller: tNamaDepan,
                          decoration: InputDecoration(
                              labelText: 'Nama Depan',
                              labelStyle: whiteTextFont,
                              hintText: "Masukkan nama depan anda",
                              hintStyle: whiteTextFont,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          // onChanged: (text) {
                          //   isPasswordValid = text.length >= 6;
                          // },
                          style: whiteTextFont,
                          keyboardType: TextInputType.name,
                          controller: tNamaBelakang,
                          decoration: InputDecoration(
                              labelText: 'Nama Belakang',
                              labelStyle: whiteTextFont,
                              hintStyle: whiteTextFont,
                              hintText: "Masukkan Nama Belakang Anda",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              nope = number.phoneNumber;
                              print('Nope ' + nope);
                            });
                          },
                          inputDecoration: InputDecoration(
                              labelText: 'Nomor Handphone',
                              labelStyle: whiteTextFont,
                              hintText: "Masukkan Nomor Handphone",
                              hintStyle: whiteTextFont,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0))),
                          selectorConfig: SelectorConfig(
                            showFlags: true,
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          textStyle: whiteTextFont,
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: whiteTextFont,
                          initialValue: number,
                          textFieldController: tNope,
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),

                        // TextField(
                        //   // onChanged: (text) {
                        //   //   isPasswordValid = text.length >= 6;
                        //   // },
                        //   style: whiteTextFont,
                        //   keyboardType: TextInputType.phone,

                        //   controller: tNope,
                        //   decoration: InputDecoration(
                        //       labelText: 'Nomor Handphone',
                        //       labelStyle: whiteTextFont,
                        //       hintStyle: whiteTextFont,
                        //       hintText: "Masukkan No Handphone Anda",
                        //       enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.white),
                        //           borderRadius: BorderRadius.circular(10.0)),
                        //       border: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.white),
                        //           borderRadius: BorderRadius.circular(10.0))),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: Get.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: redPrimary,
                                    padding: EdgeInsets.all(12),
                                    textStyle:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (tNamaBelakang.text.isEmpty ||
                                      tNamaDepan.text.isEmpty ||
                                      tNope.text.isEmpty ||
                                      tNope.text.length < 11) {
                                    Get.snackbar('Kesalahan',
                                        'Nama Depan , Nama Belakang, dan Nomor Handphone tidak boleh kosong',
                                        margin: EdgeInsets.all(12),
                                        backgroundColor: Colors.white70,
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    widget.registrationData.namaDepan =
                                        tNamaDepan.text;
                                    widget.registrationData.namaBelakang =
                                        tNamaBelakang.text;
                                    widget.registrationData.noHp = tNope.text;
                                    Get.defaultDialog(
                                        backgroundColor: Colors.white,
                                        title: 'Loading...',
                                        content: Center(
                                            child: SizedBox(
                                          height: Get.height * 0.2,
                                          child: LottieBuilder.asset(
                                              'assets/loading.json'),
                                        )));
                                    await utilsController.fetchGenre();
                                    if (utilsController.listGenre.length > 0) {
                                      print(widget.registrationData.idUser);
                                      Get.back();
                                      Get.to(PreferencePage(
                                          widget.registrationData));
                                    }
                                  }
                                  // Get.defaultDialog(
                                  //     backgroundColor: Colors.white,
                                  //     title: 'Loading...',
                                  //     content: Center(
                                  //         child: SizedBox(
                                  //       height: Get.height * 0.2,
                                  //       child: LottieBuilder.asset(
                                  //           'assets/loading.json'),
                                  //     )));
                                  // if (tEmail.text.isEmpty ||
                                  //     tPassword.text.isEmpty) {
                                  //   Get.back();
                                  //   Get.snackbar('Kesalahan',
                                  //       'Email dan Password tidak boleh kosong',
                                  //       margin: EdgeInsets.all(12),
                                  //       backgroundColor: Colors.white70,
                                  //       snackPosition: SnackPosition.BOTTOM);
                                  // } else {
                                  //   authController.login(
                                  //       tEmail.text, tPassword.text);
                                  // }
                                },
                                child: Text('Lanjut'))),
                      ],
                    )),
              ],
            ),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    tNope?.dispose();
    super.dispose();
  }
}
