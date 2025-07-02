import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invent_app/models/post_response.model.dart';

class PostService {
  final String _baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> parsed = json.decode(response.body);
        return parsed.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load posts: ${e.toString()}');
    }
  }
}
