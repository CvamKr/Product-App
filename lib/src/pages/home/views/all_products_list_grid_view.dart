import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:product_app/src/central/services/my_logger.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:product_app/src/controllers/home_controller.dart';
import 'package:product_app/src/models/product_model.dart';
import 'package:product_app/src/pages/add_product/add_product.dart';
import 'package:product_app/src/pages/home/views/product_template.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import 'all_products_gridview.dart';

class AllProductsListGridView extends StatelessWidget {
  AllProductsListGridView({Key? key}) : super(key: key);
  List<ProductModel> productList = [];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'postViewId',
      builder: (homeController) => StreamBuilder<QuerySnapshot>(
   
        stream: homeController.sortPosts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text("Loading...")),
            );
          }
          productList = snapshot.data!.docs.map((DocumentSnapshot document) {
            return ProductModel.fromJson(
                document.data() as Map<String, dynamic>, document);
          }).toList();
          logger.d("productList", productList.length.toString());

          return 
          homeController.isGridView? AllProductsGridView(productList):
          ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
            
              ProductModel productModel = productList[index];
              return ProductTemplate(productModel: productModel);
            },
          );

        
        },
      ),
    );
  }
}
