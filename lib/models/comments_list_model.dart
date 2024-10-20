import 'dart:convert';

import 'package:equatable/equatable.dart';

List<CommentsListModel> commentsListModelFromJson(String str) => List<CommentsListModel>.from(json.decode(str).map((x) => CommentsListModel.fromJson(x)));

String commentsListModelToJson(List<CommentsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentsListModel extends Equatable{
    final int postId;
    final int id;
    final String name;
    final String email;
    final String body;

    const CommentsListModel({
        required this.postId,
        required this.id,
        required this.name,
        required this.email,
        required this.body,
    });

    factory CommentsListModel.fromJson(Map<String, dynamic> json) => CommentsListModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };

    
  @override
  List<Object?> get props => [postId ,id, name, email, body];
}
