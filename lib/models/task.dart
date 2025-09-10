// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final bool? isCompleted;
  final String? image;
  final String? priorityID;
  final String? userID;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.priorityID,
    this.image,
    this.userID,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskModel(
        docId: json["docID"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        priorityID: json["priorityID"],
        image: json["image"],
        userID: json["userID"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String taskID) =>
      {
        "docID": taskID,
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
        "image": image,
        "priorityID": priorityID,
        "userID": userID,
        "createdAt": createdAt,
      };
}
