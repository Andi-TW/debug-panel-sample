import 'package:get/get.dart';

class DebugPanelModalCtrl extends GetxController {
  RxBool isExpanded = false.obs;
  double minHeight = 250.0;

  void switchExpanded() {
    isExpanded.value = !isExpanded.value;
    update();
  }
}