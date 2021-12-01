import 'package:product_app/src/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CategoryFilterDropdown extends StatelessWidget {
  const CategoryFilterDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GetBuilder<HomeController>(
        id: "SORT_CATEGORY_DROPDOWN",
        builder: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Text("Sort by", style: TextStyle(color: Colors.grey)),
            SizedBox(width: 8),
            DropdownButton<String>(
              underline: Container(),
              value: _.sortBy,
              onChanged: _.changeSortCategory,
              items: const [
                DropdownMenuItem(
                  value: "name",
                  child: Text('Name'),
                ),
                DropdownMenuItem(
                  value: "launchedAt",
                  child: Text('Recently launched'),
                ),
                DropdownMenuItem(
                  value: "popularity",
                  child: Text('popularity'),
                ),
                DropdownMenuItem(
                  value: "launchSite",
                  child: Text('Launch Site'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
