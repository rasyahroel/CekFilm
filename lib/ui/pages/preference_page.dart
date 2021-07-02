part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  UtilsController utilsController = Get.put(UtilsController());
  AuthController authController = Get.put(AuthController());
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Stack(
          children: [
            ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pilih 3 Genre\nKesukaan Kamu",
                      style: whiteTextFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: generateGenreWidgets(
                            context, utilsController.listGenre),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),

                    // Center(
                    //   child: FloatingActionButton(
                    //       elevation: 0,
                    //       backgroundColor: mainColor,
                    //       child: Icon(Icons.arrow_forward),
                    //       onPressed: () {
                    //         if (selectedGenres.length != 4) {
                    //           Flushbar(
                    //             duration: Duration(milliseconds: 1500),
                    //             flushbarPosition: FlushbarPosition.TOP,
                    //             backgroundColor: Color(0xFFFF5C83),
                    //             message: "Please select 4 genres",
                    //           )..show(context);
                    //         } else {
                    //           widget.registrationData.selectedGenres =
                    //               selectedGenres;
                    //           widget.registrationData.selectedLang =
                    //               selectedLanguage;
                    //           print("clic");
                    //           context.bloc<PageBloc>().add(
                    //               GoToAccountConfirmationPage(
                    //                   widget.registrationData));
                    //         }
                    //       }),
                    // ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )
              ],
            ),
            selectedGenres.length == 3
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    left: 10,
                    child: Container(
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
                              if (selectedGenres.length == 0) {
                                Get.snackbar('Pilih Genre',
                                    'Kamu belum memilih genre apapun',
                                    margin: EdgeInsets.all(12),
                                    backgroundColor: Colors.white70,
                                    snackPosition: SnackPosition.BOTTOM);
                              } else {
                                widget.registrationData.selectedGenres =
                                    selectedGenres;
                                Get.defaultDialog(
                                    backgroundColor: Colors.white,
                                    title: 'Loading...',
                                    content: Center(
                                        child: SizedBox(
                                      height: Get.height * 0.2,
                                      child: LottieBuilder.asset(
                                          'assets/loading.json'),
                                    )));
                                print(widget.registrationData.idUser);
                                String signature =
                                    await SmsAutoFill().getAppSignature;
                                print(signature);

                                authController.sendOtp(widget.registrationData);
                                Get.back();

                                // authController
                                //     .createUser(widget.registrationData);
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
                            child: Text('Selesai'))),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  List<Widget> generateGenreWidgets(BuildContext context, List<Genre> genre) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return genre
        .map((e) => SelectedTableBox(
              e.name,
              width: width,
              isSelected: selectedGenres.contains(e.id.toString()),
              onTap: () {
                onSelectGenre(e.id.toString());
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 3) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
