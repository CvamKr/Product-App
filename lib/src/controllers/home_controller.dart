import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_app/src/central/services/my_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  bool isGridView = false;
  String sortBy = "launchedAt";

  changeSortCategory(String? category) {
    logger.d('category $category');
    sortBy = category!;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      update(['SORT_CATEGORY_DROPDOWN', 'postViewId']);
    });
  }

  Stream<QuerySnapshot> sortPosts() {
    bool orderValue = false;
    if (sortBy == "name" || sortBy == "launchSite") {
      orderValue = false;
    } else {
      orderValue = true;
    }
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy(sortBy, descending: orderValue)
        .snapshots();
  }
}
