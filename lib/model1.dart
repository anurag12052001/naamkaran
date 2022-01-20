import 'package:flutter/material.dart';

class Religion {
  String? id;
  String? categoryId;
  String? name;
  String? meaning;
  String? gender;
  bool isFav = false;

  Religion(
      {this.id,
      this.categoryId,
      this.name,
      this.meaning,
      this.gender,
      this.isFav = false});

  Religion.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.categoryId = json["category_id"];
    this.name = json["name"];
    this.meaning = json["meaning"];
    this.gender = json["gender"];
    this.isFav = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["category_id"] = this.categoryId;
    data["name"] = this.name;
    data["meaning"] = this.meaning;
    data["gender"] = this.gender;
    return data;
  }
}
