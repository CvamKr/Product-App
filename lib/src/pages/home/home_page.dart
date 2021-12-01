import 'package:flutter/foundation.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:product_app/src/controllers/home_controller.dart';
import 'package:product_app/src/models/product_model.dart';
import 'package:product_app/src/pages/add_product/add_product.dart';
import 'package:product_app/src/pages/home/views/all_products_list_grid_view.dart';
import 'package:product_app/src/pages/home/views/category_filter_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProductApp"),
        actions: [
          GetBuilder<HomeController>(
              id: 'postViewId',
              builder: (controller) {
                return IconButton(
                    icon: Icon(controller.isGridView
                        ? Icons.list_alt
                        : Icons.grid_view),
                    onPressed: () {
                      if (kIsWeb) {
                        controller.isGridView = !controller.isGridView;
                        controller.update(['postViewId']);
                      } else {
                        Get.snackbar("", "Open on web to view GridView");
                      }
                    });
              }),
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                final addProductController = Get.find<AddProductController>();
                addProductController.productModel = ProductModel(picsList: []);
                addProductController.nameOfProductToEdit = "anything";
                Get.to(() => AddProductPage(
                      appBarTitle: "Add Product",
                    ));
              }),
        ],
      ),
      body: Column(
        children: [
          const CategoryFilterDropdown(),
          Container(color: Colors.grey, height: 1),
          Flexible(child: AllProductsListGridView())
        ],
      ),
    );
  }
}
