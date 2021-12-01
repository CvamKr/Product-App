import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';

class PopularityStars extends StatelessWidget {
  PopularityStars({Key? key}) : super(key: key);
  final addProductController = Get.find<AddProductController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("*Popularity"),
        const SizedBox(height: 8),
        RatingBar.builder(
          initialRating: addProductController.productModel.popularity,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            addProductController.productModel.popularity = rating;
          },
        ),
      ],
    );
  }
}
