import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class SubCategoryModel {
  String name;
  String image;
  String cid;
  String sid;

  SubCategoryModel({required this.name, required this.image, required this.cid, required this.sid});

  factory SubCategoryModel.fromJson(json) {
    return SubCategoryModel(
      name: json['name'],
      image: json['image'],
      cid: json['cid'],
      sid: json['sid'],
    );
  }
}
