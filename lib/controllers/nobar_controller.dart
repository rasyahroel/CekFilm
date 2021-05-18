part of 'controllers.dart';

class NobarController extends GetxController {
  var listNobar = <Nobar>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNobarList();
  }

  fetchNobarList() async {
    isLoading(true);
    List<Nobar> result = await NobarServices.getNobar();
    print(result.length);
    listNobar.assignAll(result);
    isLoading(false);
  }
}
