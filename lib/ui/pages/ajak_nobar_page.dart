part of 'pages.dart';

class AjakNobarPage extends StatefulWidget {
  final DetailMovie movie;
  AjakNobarPage(this.movie);
  @override
  _AjakNobarPageState createState() => _AjakNobarPageState();
}

class _AjakNobarPageState extends State<AjakNobarPage> {
  TextEditingController tDate = TextEditingController();
  TextEditingController tDesc = TextEditingController();
  TextEditingController tProvinsi = TextEditingController();
  TextEditingController tKab = TextEditingController();
  TextEditingController tMaxPerson = TextEditingController();
  bool freeTicket = false;
  int maxPerson;
  DateTime schedule;
  String idProv;
  String idKab;
  final UtilsController utilsController = Get.put(UtilsController());
  final NobarController nobarController = Get.put(NobarController());
  void getCalendar() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleDayButton: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        textStyleYearButton: TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 80),
      theme: ThemeData(primarySwatch: Colors.green),
    );
    setState(() {
      schedule = newDateTime;
      tDate.text = DateFormat("dd MMMM yyyy", "id_ID").format(newDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Bikin Ajakan Nobar',
          style: whiteTextFont.copyWith(
              fontWeight: FontWeight.bold, fontSize: Get.height * 0.025),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back(closeOverlays: true);
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Obx(() => Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: widget.movie.posterPath == ""
                                ? Container(
                                    color: Colors.grey,
                                    width: Get.width * 0.12,
                                    height: Get.height * 0.10,
                                    child: Center(
                                      child: Text(
                                        'NO POSTER',
                                        style: whiteTextFont.copyWith(
                                            fontSize: Get.height * 0.008),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: Get.width * 0.1,
                                    height: Get.height * 0.15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                baseUrlImageTmdbW500 +
                                                    widget.movie.posterPath),
                                            fit: BoxFit.fill)),
                                  ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.5,
                                      child: Text(widget.movie.title,
                                          style: whiteTextFont),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.5,
                                      child: Wrap(
                                        children: widget.movie.genres
                                            .map((e) => Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 8.0, top: 8),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                        color: RandomColor()
                                                            .randomColor(
                                                                colorBrightness:
                                                                    ColorBrightness
                                                                        .dark),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Text(
                                                      e.name,
                                                      style: whiteTextFont
                                                          .copyWith(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.015),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Ajakan', style: whiteTextFont),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      minLines: 1,
                      maxLines: 6,
                      style:
                          whiteTextFont.copyWith(fontSize: Get.height * 0.02),
                      controller: tDesc,
                      decoration: InputDecoration(
                          hintText: 'Ketikan ajakan anda\n',
                          hintStyle: whiteTextFont.copyWith(
                              fontSize: Get.height * 0.02),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(height: 20),
                    Text('Tanggal Nobar', style: whiteTextFont),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        var date = new DateTime.now();
                        getCalendar();
                      },
                      child: TextField(
                        // onChanged: (text) {
                        //   isPasswordValid = text.length >= 6;
                        // },
                        style:
                            whiteTextFont.copyWith(fontSize: Get.height * 0.02),
                        controller: tDate,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Klik untuk memilih",
                            hintStyle: whiteTextFont.copyWith(
                                fontSize: Get.height * 0.02),
                            fillColor: Colors.white,
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Maksimal Orang', style: whiteTextFont),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      // onChanged: (text) {
                      //   isPasswordValid = text.length >= 6;
                      // },
                      style:
                          whiteTextFont.copyWith(fontSize: Get.height * 0.02),
                      controller: tMaxPerson,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText:
                              "Maksimal orang yang diperbolehkan bergabung",
                          hintStyle: whiteTextFont.copyWith(
                              fontSize: Get.height * 0.02),
                          fillColor: Colors.white,
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    SizedBox(height: 20),
                    Text('Provinsi', style: whiteTextFont),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentColor2),
                      ),
                      child: DropdownButton(
                        dropdownColor: Colors.white54,
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text("Pilih provinsi anda",
                            style: whiteTextFont.copyWith(
                                fontSize: Get.height * 0.02)),
                        value: idProv,
                        items: utilsController.listProv.map((value) {
                          return DropdownMenuItem(
                            child: Text(value['nama'],
                                style: whiteTextFont.copyWith(
                                    fontSize: Get.height * 0.02)),
                            value: value['id_prov'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            idProv = value;
                            utilsController.fetchKab(value);
                            idKab = null;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: utilsController.listKab.length > 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text('Kabupaten', style: whiteTextFont),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: accentColor2),
                            ),
                            child: DropdownButton(
                              dropdownColor: Colors.white54,
                              isExpanded: true,
                              underline: SizedBox(),
                              hint: Text("Pilih kabupaten anda",
                                  style: whiteTextFont.copyWith(
                                      fontSize: Get.height * 0.02)),
                              value: idKab,
                              items: utilsController.listKab.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value['nama'],
                                      style: whiteTextFont.copyWith(
                                          fontSize: Get.height * 0.02)),
                                  value: value['id_kab'],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  idKab = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            activeColor: yellowPrimary,
                            value: freeTicket,
                            onChanged: (value) {
                              setState(() {
                                freeTicket = value;
                              });
                            }),
                        Flexible(
                          flex: 1,
                          child: Text('Di Traktir Tiket',
                              style: whiteTextFont, maxLines: 3),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: Get.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: yellowPrimary,
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            print(
                                '${schedule.year}-${schedule.month}-${schedule.day}');
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            nobarController.createNobar(
                                widget.movie.id.toString(),
                                tMaxPerson.text,
                                tDesc.text,
                                freeTicket ? '1' : '2',
                                '${schedule.year}-${schedule.month}-${schedule.day}',
                                idKab,
                                widget.movie.posterPath);
                            // Get.to(AjakNobarPage(
                            //     movieController.detailMovie.value));
                          },
                          child: nobarController.isLoading.value
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: yellowPrimary,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  )),
                                )
                              : Text('Selesai',
                                  style: whiteTextFont.copyWith(
                                      fontWeight: FontWeight.bold))),
                    ),
                  ],
                )))
          ],
        ),
      ),
    );
  }
}
