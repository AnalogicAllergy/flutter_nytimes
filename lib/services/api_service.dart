import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nytimes/models/article_model.dart';
import 'package:nytimes/secrets/apiKey.dart';

class APIService {
  final String _baseUrl = 'api.nytimes.com';
  final String apiKey = Secrets().apiKey;

  Future<List<Article>> fetchArticlesBySection(String section) async {
    Map<String, String> parameters = {
      'api-key': apiKey,
    };
    Uri uri =
        Uri.https(_baseUrl, '/svc/topstories/v2/$section.json', parameters);
    try {
      var response = await http.get(uri);
      Map<String, dynamic> data = json.decode(response.body);
      List<Article> articles = [];
      data['results']
          .forEach((articleMap) => articles.add(Article.fromMap(articleMap)));
      return articles;
    } catch (e) {
      throw e.toString();
    }
  }
}
