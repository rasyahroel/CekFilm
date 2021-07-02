part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final Users user;
  EditProfilePage(this.user);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController tNamaDepan = TextEditingController();
  TextEditingController tNamaBelakang = TextEditingController();
  TextEditingController tEmail = TextEditingController();
  AuthController authController = Get.put(AuthController());
  final picker = ImagePicker();
  File profilImage;
  void _onAlertPress() async {
    Get.defaultDialog(
        title: 'Ambil Foto',
        titleStyle: blackTextFont,
        content: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.camera, profilImage);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: yellowPrimary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: Get.height * 0.05,
                        ),
                      ),
                      Text(
                        'Kamera',
                        style: blackTextFont,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getImage(ImageSource.gallery, profilImage);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: yellowPrimary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.folder,
                          color: Colors.white,
                          size: Get.height * 0.05,
                        ),
                      ),
                      Text(
                        'File',
                        style: blackTextFont,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future getImage(ImageSource source, File _image) async {
    final image =
        await picker.getImage(source: source, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (image != null) {
        profilImage = File(image.path);
        print(profilImage.readAsBytesSync().lengthInBytes / 1024);
        Get.back();
      } else {
        Get.back();
        getSnackbar('Gagal', 'Gagal mengambil foto');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    tNamaDepan.text = widget.user.namaDepan;
    tNamaBelakang.text = widget.user.namaBelakang;
    tEmail.text = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Ubah Profil',
          style: whiteTextFont.copyWith(
              fontWeight: FontWeight.bold, fontSize: Get.height * 0.025),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back(closeOverlays: true);
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      backgroundColor: blackPrimary,
      body: SafeArea(
          child: ListView(
        children: [
          Container(
              height: Get.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pattern_movie.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    profilImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.file(profilImage,
                                height: Get.height * 0.2,
                                width: Get.height * 0.2,
                                fit: BoxFit.cover),
                          )
                        : widget.user.profilePath == "" ||
                                widget.user.profilePath == null
                            ? SvgPicture.asset('assets/avatar.svg',
                                height: Get.height * 0.2,
                                color: RandomColor().randomColor(
                                    colorBrightness: ColorBrightness.light))
                            : Container(
                                width: Get.height * 0.2,
                                height: Get.height * 0.2,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(
                                            widget.user.profilePath)))),
                    SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: yellowPrimary,
                            padding: EdgeInsets.all(8),
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _onAlertPress();
                          // Get.defaultDialog(
                          //     backgroundColor: Colors.white,
                          //     title: 'Loading...',
                          //     content: Center(
                          //         child: SizedBox(
                          //       height: Get.height * 0.2,
                          //       child: LottieBuilder.asset(
                          //           'assets/loading.json'),
                          //     )));
                        },
                        child: Text('Ganti Foto', style: whiteTextFont)),
                  ],
                ),
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Depan', style: whiteTextFont),
                  SizedBox(height: 10),
                  TextField(
                    // onChanged: (text) {
                    //   isPasswordValid = text.length >= 6;
                    // },
                    style: whiteTextFont,
                    controller: tNamaDepan,
                    decoration: InputDecoration(
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
                  Text('Nama Belakang', style: whiteTextFont),
                  SizedBox(height: 10),
                  TextField(
                    // onChanged: (text) {
                    //   isPasswordValid = text.length >= 6;
                    // },
                    style: whiteTextFont,
                    controller: tNamaBelakang,
                    decoration: InputDecoration(
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
                  Text('Email', style: whiteTextFont),
                  SizedBox(height: 10),
                  TextField(
                    // onChanged: (text) {
                    //   isPasswordValid = text.length >= 6;
                    // },
                    style: whiteTextFont,
                    controller: tEmail,
                    decoration: InputDecoration(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Genre Favorite', style: whiteTextFont),
                      Text('Ubah', style: yellowTextFont),
                    ],
                  ),
                  Wrap(
                    children: authController.genreUser
                        .map((e) => Padding(
                              padding: EdgeInsets.only(right: 8.0, top: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    color: RandomColor().randomColor(
                                        colorBrightness: ColorBrightness.dark),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  e.name,
                                  style: whiteTextFont.copyWith(
                                      fontSize: Get.height * 0.02),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: Get.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.all(12),
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
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
                            Get.snackbar('Berhasil', 'Profil berhasil di ubah',
                                margin: EdgeInsets.all(12),
                                backgroundColor: Colors.white60,
                                snackPosition: SnackPosition.BOTTOM);
                          },
                          child: Text('Simpan', style: blackTextFont))),
                ],
              )),
        ],
      )),
    );
  }
}
