import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task/models/Post.dart';

// ImageRepostory class which contain method related to CRUD opertaion
class PostRepository {
  /// since i am fetching single simple post with help of
  /// future provider so it handle the exception by default.
  /// but in other case we could user more advance package fpdart
  /// which provide conditional result based upon success and failure.

  /// ```    Future<List<Post>> fetchImagePost(String query) async {
  ///          try {
  ///                final response = await http.get(
  ///                Uri.parse(
  ///                   'https://pixabay.com/api/?key=29478997-d6a6371eb641864f24b1b39e3&q=$query&image_type=photo'),
  ///                       );
  ///         final jsonResponse = jsonDecode(response.body)['hits'] as List;
  ///         return jsonResponse.map((e) => Post.fromJson(e)).toList();
  ///       } catch (e) {
  ///         throw Exception(e);
  ///   }
  ///  }```
  ///

  Future<List<Post>> fetchImagePost(String query) async {
    final response = await http.get(
      Uri.parse(
          'https://pixabay.com/api/?key=29478997-d6a6371eb641864f24b1b39e3&q=$query&image_type=photo'),
    );
    final jsonResponse = jsonDecode(response.body)['hits'] as List;
    return jsonResponse.map((e) => Post.fromJson(e)).toList();
  }
}
