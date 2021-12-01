import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_app/src/central/services/image_service.dart';
import 'package:product_app/src/central/services/my_logger.dart';
import 'package:product_app/src/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'home_controller.dart';

class AddProductController extends GetxController {

  String nameOfProductToEdit = "";

  ProductModel productModel = ProductModel(picsList: []);
  TextEditingController nameTeCtrl = TextEditingController();
  TextEditingController siteTeCtrl = TextEditingController();
  TextEditingController popularityTeCtrl = TextEditingController();

  bool isUploading = false;

  final CollectionReference productCol =
      FirebaseFirestore.instance.collection('products');

  final homeController = Get.find<HomeController>();

  Future postProduct() async {
    feedProductData();
    if (!validateData()) {
      return;
    }

    isUploading = true;
    update(['ADD_PRODUCT_PAGE']);
    try {
      // await uploadImages();
      productCol.add(productModel.toJson()).then((docRef) {
        logger.d("product uploaded");
      }).catchError((error) {
        logger.e('firestore error $error');
      });
    } catch (e) {
      logger.e(e);
      isUploading = false;
      update(['ADD_PRODUCT_PAGE']);
    } finally {
      //resetData
      productModel = ProductModel(
        picsList: [],
        launchedAt: null,
      );
      isUploading = false;
      Get.back();
      homeController.changeSortCategory("launchedAt");
    }
  }

  feedProductData() {
    productModel
      ..name = nameTeCtrl.text
      ..launchSite = siteTeCtrl.text;
  }

  bool productExists = false;
  bool validateData() {
    if (productModel.name == "" ||
            productModel.launchedAt == null ||
            productModel.launchSite == "" ||
            productModel.popularity == 0
        // || imagesPath.isEmpty

        ) {
      Get.snackbar("", "All *marked fields are compusory");
      return false;
    }
    if (productExists) {
      if (nameOfProductToEdit == "anything" ||
          nameOfProductToEdit != productModel.name) {
        //ie new product is being added or product being edited has a different name.
        Get.snackbar("Opps!", "Product already exists. Can't be added.");
        return false;
      } else {
        //product exists but product being edited has the same name.
        return true;
      }
    }
    return true;
  }

  Stream<QuerySnapshot<Object?>> checkProductExists(productTitle) {
    logger.d("in checkProductExists", productTitle);
    return productCol.where("name", isEqualTo: productTitle).snapshots();
  }

  feedInitialData() {
    logger.d("feedInitialData()");
    nameTeCtrl.text = productModel.name;
    siteTeCtrl.text = productModel.launchSite;
    popularityTeCtrl.text = productModel.popularity.toString();
  }

  void deleteProduct(productModel) {
    productCol.doc(productModel.id).delete();
  }

  updateProduct() async {
    feedProductData();

    if (!validateData()) {
      // Get.snackbar("Opps!", "All *marked fields are compusory");
      return;
    }
    isUploading = true;
    update(['ADD_PRODUCT_PAGE']);
    await productCol.doc(productModel.id).update(productModel.toJson());
    isUploading = false;
    update(['ADD_PRODUCT_PAGE']);
    Get.back();
    homeController.changeSortCategory("launchedAt");
  }
}
