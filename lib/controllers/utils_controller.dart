part of 'controllers.dart';

class UtilsController extends GetxController {
  RxList<Genre> listGenre = <Genre>[].obs;

  fetchGenre() async {
    List<Genre> list = await UtilsServices.getListGenre();
    listGenre.assignAll(list);
  }
}
