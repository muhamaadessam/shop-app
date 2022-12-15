import 'package:get/get.dart';

class HomeController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    index != 2 ? tabIndex = index : null;
    update();
  }
}
