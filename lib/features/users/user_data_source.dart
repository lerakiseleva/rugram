import 'package:dio/dio.dart';
import 'package:rugram/data/remote_data_sources/models/list_model.dart'
    as source_source_list_model;
import 'package:rugram/data/remote_data_sources/models/post_preview.dart'
    as source_post_preview;
import 'package:rugram/domain/models/list_model.dart';
import 'package:rugram/domain/models/post_create.dart';
import 'package:rugram/domain/models/post_preview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserDataSource {
  final Dio dio;

  UserDataSource(this.dio);

  //Future<void> createPost(PostCreate postCreate) async {}
  // Функция для создания новой записи
  Future<void> createPost() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': 'New Post',
        'body': 'This is a new post created through dummy API',
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      print('Post created successfully');

      // Получение созданных данных post
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Created Post Data: $responseData');
    } else {
      print('Failed to create post');
    }
  }

  Future<void> updatePost(PostCreate postCreate) async {}

  Future<void> deletePost(PostCreate postCreate) async {}
}
