import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:product_app/src/models/product_model.dart';

class DeleteIcon extends StatelessWidget {
  ProductModel productModel;

  DeleteIcon({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(Icons.delete, size: 16),
      onPressed: () {
        showDeleteDialog(context);
      },
    ));
  }

  showDeleteDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget deleteButton = ElevatedButton(
      child: Text("Delete"),
      onPressed: () {
        Get.find<AddProductController>().deleteProduct(productModel);
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Do you really want to delete?"),
      // content: Text("Do you really want to delete?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
