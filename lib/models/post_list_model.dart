// To parse this JSON data, do
//
//     final PostListModel = PostListModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<PostListModel> postListModelFromJson(String str) =>
    List<PostListModel>.from(
        json.decode(str).map((x) => PostListModel.fromJson(x)));

String postListModelToJson(List<PostListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostListModel extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostListModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostListModel.fromJson(Map<String, dynamic> json) => PostListModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  List<Object?> get props => [id, title, body, userId];
}
