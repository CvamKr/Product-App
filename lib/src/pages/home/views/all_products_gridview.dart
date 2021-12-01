import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/src/controllers/home_controller.dart';

import 'product_template.dart';

class AllProductsGridView extends StatelessWidget {
  List productList;
  AllProductsGridView(this.productList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: constraints.maxWidth < 720 ? 4 / 3 : 5 / 3.2,
          crossAxisCount: constraints.maxWidth < 720 ? 2 : 3,
          // crossAxisCount: 3,
        ),
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: ProductTemplate(
              productModel: productList[index],
            ),
          );
        },
      );
    });
  }
}
