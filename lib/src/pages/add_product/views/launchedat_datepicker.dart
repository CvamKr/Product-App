import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/src/controllers/add_product_controller.dart';

class LaunchedAtDatePicker extends StatefulWidget {
  const LaunchedAtDatePicker({Key? key}) : super(key: key);

  @override
  State<LaunchedAtDatePicker> createState() => _LaunchedAtDatePickerState();
}

class _LaunchedAtDatePickerState extends State<LaunchedAtDatePicker> {
  final addProductController = Get.find<AddProductController>();
  String s = "Pick";
  // DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        addProductController.productModel.launchedAt = picked;
        // selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("*Launch Date"),
        SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            // child: Text(picked != null ? picked.toString().split(" ")[0] : s),
            child: Text(addProductController.productModel.launchedAt != null
                ? addProductController.productModel.launchedAt
                    .toString()
                    .split(" ")[0]
                : s),
          ),
        ),
      ],
    );
  }
}
