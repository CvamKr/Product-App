import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:product_app/src/controllers/home_controller.dart';
import 'package:product_app/src/models/product_model.dart';

class Rating extends StatelessWidget {
  Rating({Key? key, required this.productModel}) : super(key: key);
  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 16,
      ignoreGestures: true,
      initialRating: productModel.popularity,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.only(right: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double value) {
        print("rating; $value");
      },
    );
  }
}
