import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class CategoryModel {
  String name;
  String image;
  String cid;

  CategoryModel({
    required this.name,
    required this.image,
    required this.cid,
  });

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      name: json['name'],
      image: json['image'],
      cid: json['cid'],
    );
  }
}
