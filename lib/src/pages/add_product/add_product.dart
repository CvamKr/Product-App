import 'package:product_app/src/central/services/my_logger.dart';
import 'package:product_app/src/central/widgets/build_swiper.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/src/models/product_model.dart';
import 'package:product_app/src/pages/add_product/views/launchedat_datepicker.dart';
import 'package:product_app/src/pages/add_product/views/site_popularity_tf.dart';

import 'views/name_tf.dart';

class AddProductPage extends StatefulWidget {
  final String appBarTitle;
  const AddProductPage({Key? key, required this.appBarTitle}) : super(key: key);
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final addProductController = Get.find<AddProductController>();

  @override
  void initState() {
    super.initState();
    addProductController.feedInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
        id: 'ADD_PRODUCT_PAGE',
        builder: (_) {
          return _.isUploading == true
              ? const Material(
                  child: Center(child: CircularProgressIndicator()))
              : Scaffold(
                  appBar: AppBar(
                    title: Text(widget.appBarTitle),
                    actions: [
                      ElevatedButton(
                        onPressed: () async {
                          addProductController.nameOfProductToEdit == "anything"
                              ? await addProductController.postProduct()
                              : await addProductController.updateProduct();

                        },
                        child: Text(addProductController.nameOfProductToEdit ==
                                "anything"
                            ? 'Upload'
                            : "Update"),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        NameTf(),

                        Align(
                            alignment: Alignment.centerLeft,
                            child: SitePopulaityTf()),

                        const SizedBox(height: 24),
                        const LaunchedAtDatePicker()
                   
                      ],
                    ),
                  ),
                );
        });
  }
}
