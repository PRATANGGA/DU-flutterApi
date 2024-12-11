import 'dart:convert';

import 'package:app/core/constants/constant.dart';
import 'package:app/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final url = Uri.parse(
          '$BaseUrl/top-headlines?country=$topHeadlines&apiKey=$ApiKey');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> articleJson = jsonDecode(response.body)['articles'];
        return articleJson.map((json) => ArticleModel.fromjson(json)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
