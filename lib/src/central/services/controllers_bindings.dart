import 'package:product_app/src/central/services/image_service.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:product_app/src/controllers/home_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';


class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductController>(() => AddProductController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
        
  }
}
