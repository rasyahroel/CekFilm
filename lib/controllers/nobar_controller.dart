part of 'controllers.dart';

class NobarController extends GetxController {
  var listNobar = <Nobar>[].obs;
  var listMyNobar = <Nobar>[].obs;
  var listParticipant = <Participant>[].obs;
  var isLoading = false.obs;
  var pref = GetStorage();
  var isJoin = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchNobarList();
    fetchMyNobarList();
  }

  chatWa(String noHp) async {
    // add the [https]
    String url = "https://wa.me/$noHp/?text=${Uri.parse('Hi')}";
    Get.back();
    await launch(url);
  }

  fetchNobarList() async {
    isLoading(true);
    List<Nobar> result = await NobarServices.getNobar();
    if (result.length > 0) {
      listNobar.assignAll(result);
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  fetchMyNobarList() async {
    isLoading(true);
    List<Nobar> result = await NobarServices.getMyNobar(pref.read('idUser'));
    if (result.length > 0) {
      listMyNobar.assignAll(result);
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  createNobar(
      String idMovie,
      String maxPerson,
      String ajakan,
      String freeTicket,
      String schedule,
      String idKab,
      String posterPath) async {
    isLoading(true);
    bool result = await NobarServices.createNobar(pref.read('idUser'), idMovie,
        maxPerson, ajakan, freeTicket, schedule, idKab, posterPath);
    if (result) {
      fetchNobarList();
      Get.off(NobarPage());
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  fetchParticipant(String idNobar) async {
    isLoading(true);
    List<Participant> result = await NobarServices.getListParticipant(idNobar);
    listParticipant.assignAll(result);
    isLoading(false);
  }

  joinNobar(String idNobar) async {
    bool result = await NobarServices.joinNobar(idNobar, pref.read('idUser'));
    if (result) {
      isJoin(true);
      Get.back();
      fetchParticipant(idNobar);
      Get.snackbar('Pesan',
          'Berhasil, tunggu sampai pembuat nobar akan menghubungi kamu',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.back();
      Get.snackbar('Pesan', 'Gagal',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  selesaiNobar(String idNobar) async {
    bool result = await NobarServices.selesaiNobar(idNobar);
    if (result) {
      Get.back();
      Get.snackbar('Pesan', 'Berhasil',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
      Get.off(MainPage(
        bottomNavBarIndex: 2,
      ));
    } else {
      Get.back();
      Get.snackbar('Pesan', 'Gagal',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  batalkanNobar(String idNobar) async {
    bool result = await NobarServices.batalkanNobar(idNobar);
    if (result) {
      Get.back();
      Get.snackbar('Pesan', 'Berhasil',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
      Get.off(MainPage(
        bottomNavBarIndex: 2,
      ));
    } else {
      Get.back();
      Get.snackbar('Pesan', 'Gagal',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  accNobar(String idUser, String idNobar) async {
    bool result = await NobarServices.accNobar(idUser, idNobar);
    if (result) {
      Get.back();
      Get.snackbar('Pesan', 'Berhasil',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.back();
      Get.snackbar('Pesan', 'Gagal',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white60,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
