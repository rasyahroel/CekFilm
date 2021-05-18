import 'package:cek_film_app/controllers/controllers.dart';
import 'package:cek_film_app/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Root extends GetWidget<AuthController> {
  final AuthController authController = Get.put(AuthController());
  final GetStorage pref = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (authController.user != null) ? MainPage() : LoginPage();
    });
  }
}
