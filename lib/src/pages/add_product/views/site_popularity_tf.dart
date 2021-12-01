import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';

import 'popularity_stars.dart';

class SitePopulaityTf extends StatelessWidget {
  SitePopulaityTf({Key? key}) : super(key: key);
  final addProductController = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: addProductController.siteTeCtrl,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            labelText: "*Launch Site",
            // hintText: "",
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 32),
        PopularityStars()
        // TextField(
        //   controller: addProductController.popularityTeCtrl,
        //   textCapitalization: TextCapitalization.sentences,
        //   keyboardType: TextInputType.number,
        //   maxLines: null,
        //   decoration: InputDecoration(
        //     labelStyle: const TextStyle(
        //       color: Colors.grey,
        //       fontSize: 14,
        //     ),
        //     labelText: "*Popularity",
        //     hintText: "Enter a number from 1 to 10",
        //     hintStyle: TextStyle(
        //       color: Colors.grey[500],
        //       fontSize: 14,
        //       fontWeight: FontWeight.normal,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
