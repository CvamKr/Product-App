


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {this.id = "",
      this.name = "",
      this.launchedAt,
      this.launchSite = "",
      this.popularity = 1,
      required this.picsList});

  String id;
  String name;
  DateTime? launchedAt;
  String launchSite;
  double popularity;
  List<String> picsList;

  factory ProductModel.fromJson(
          Map<String, dynamic> json, DocumentSnapshot doc) =>
      ProductModel(
          id: doc.id,
          name: json["name"],
          launchedAt: (json['launchedAt']).toDate(),
          launchSite: json["launchSite"],
          popularity: json["popularity"],
          picsList: List<String>.from(json["picsList"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "name": name,
        "launchedAt": launchedAt,
        "launchSite": launchSite,
        "popularity": popularity,
        "picsList": List<dynamic>.from(picsList.map((x) => x)),
      };
}



