import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:product_app/src/controllers/home_controller.dart';
import 'package:product_app/src/models/product_model.dart';
import 'package:product_app/src/pages/add_product/add_product.dart';
import 'package:flutter/material.dart';
import 'package:product_app/src/pages/home/views/rating.dart';

import 'delete_icon.dart';

class ProductTemplate extends StatelessWidget {
  ProductTemplate({Key? key, required this.productModel}) : super(key: key);
  ProductModel productModel;
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildProductInitialWithRandomColor(),
              Expanded(
                child: buildProductDetails(),
              ),
              // Spacer(),
              buildEditDeleteIcons()
            ]),
      ),
    );
  }

  Column buildEditDeleteIcons() {
    return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                IconButton(
                    icon: const Icon(Icons.edit, size: 16),
                    onPressed: () {
                      final addProductController =
                          Get.find<AddProductController>();
                      addProductController.productModel = productModel;
                      addProductController.nameOfProductToEdit =
                          productModel.name;
                      Get.to(() => const AddProductPage(
                            appBarTitle: "Edit Product",
                          ));
                    }),
                DeleteIcon(
                  productModel: productModel,
                ),
              ],
            );
  }

  Padding buildProductDetails() {
    return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Rating(productModel: productModel),
                    const SizedBox(height: 8),
                    Text(
                      productModel.launchSite,
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      productModel.launchedAt.toString().split(" ")[0],
                      style: const TextStyle(
                        color: Colors.grey,
                        // fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
  }

  Padding buildProductInitialWithRandomColor() {
    return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                  width: 85,
                  height: 90,
                  decoration: BoxDecoration(
                      color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)],
                      // border: Border.all(
                      //   color: Colors.red[500],
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        productModel.name.substring(0, 1),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  )),
            );
  }
}
