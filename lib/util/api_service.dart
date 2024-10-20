import 'dart:convert';
import 'package:flutter_test_task/models/comments_list_model.dart';
import 'package:flutter_test_task/models/post_list_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://jsonplaceholder.typicode.com/"; // Replace with your API URL

  Future<List<PostListModel>> fetchPosts() async {
    final response = await http.get(
      Uri.parse("${baseUrl}posts"),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PostListModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<List<CommentsListModel>> fetchComments(String fetchType) async {
    final response = await http.get(
      Uri.parse(baseUrl + fetchType),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => CommentsListModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Map<String, dynamic>> addPost(
    String userId,
    String title,
    String body,
  ) async {
    final response = await http.post(
      Uri.parse("${baseUrl}posts"),
      body: {
        "title": title,
        "body": body,
        "userId": userId,
      },
      // headers: {
      //   'Content-type': 'application/json; charset=UTF-8',
      // },
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      // print(mapResponse);

      return mapResponse;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Map<String, dynamic>> editPost(
    String id,
    String userId,
    String title,
    String body,
  ) async {
    final response = await http.put(
      Uri.parse("${baseUrl}posts/$id"),
      body: {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
      },
      // headers: {
      //   'Content-type': 'application/json; charset=UTF-8',
      // },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<String> deletePost(
    int id,
  ) async {
    final response = await http.delete(
      Uri.parse("${baseUrl}posts/$id"),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return "Post deleted";
    } else {
      throw Exception('Failed to load items');
    }
  }
}
