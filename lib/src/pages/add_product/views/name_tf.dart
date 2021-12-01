import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_app/src/central/services/my_logger.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:product_app/src/models/product_model.dart';

class NameTf extends StatelessWidget {
  NameTf({Key? key}) : super(key: key);
  final addProductController = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (productTitle) {
            addProductController.update(["nameTfId"]);
            // addProductController.titleCtrl.text = productTitle;
            // addProductController.checkProductExists(
            //     addProductController.titleCtrl.text);
          },
          controller: addProductController.nameTeCtrl,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            labelText: "*Product Name",
            hintText: "Should be unique",
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        GetBuilder<AddProductController>(
          id: "nameTfId",
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: addProductController
                      .checkProductExists(addProductController.nameTeCtrl.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("some error");
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        addProductController.productExists = false;
                        if (addProductController.nameTeCtrl.text.isEmpty) {
                          return Container();
                        }
                        return const Text("Yay! Product can be added.",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.green));
                      } else {
                        addProductController.productExists = true;
                        logger.d(
                            "addProductController.nameOfProductToEdit : ${addProductController.nameOfProductToEdit}");
                        return addProductController.nameOfProductToEdit ==
                                addProductController.nameTeCtrl.text
                            ? Container()
                            : const Text(
                                "Oops! Product already exists. Can't be added.",
                                style: TextStyle(color: Colors.red));
                      }
                    } else {
                      return const Text("checking...");
                    }
                  }),
            );
          },
        ),
      ],
    );
  }
}
