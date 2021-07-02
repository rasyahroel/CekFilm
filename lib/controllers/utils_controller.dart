part of 'controllers.dart';

class UtilsController extends GetxController {
  RxList<Genre> listGenre = <Genre>[].obs;
  RxList listProv = [].obs;
  RxList listKab = [].obs;

  fetchGenre() async {
    List<Genre> list = await UtilsServices.getListGenre();
    if (list.length > 0) {
      listGenre.assignAll(list);
    } else {
      Get.back();
      Get.snackbar('Terjadi Kesalahan', 'Terjadi kesalahan',
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white70,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  fetchProv() async {
    List result = await UtilsServices.getProvinsi();
    listProv.assignAll(result);
  }

  fetchKab(String idProv) async {
    List result = await UtilsServices.getKab(idProv);
    listKab.assignAll(result);
  }
}
