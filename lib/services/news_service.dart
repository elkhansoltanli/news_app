import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {

  static const String _apiKey = '4a860c04471b40e583000afa98cb1eab';
  static const String _baseUrl = 'https://newsapi.org/v2';

  /// Fetches top headlines for a given set of categories.
  /// If the categories set is empty, it fetches general top headlines.
  static Future<List<Article>> fetchTopHeadlines(Set<String> categories) async {
    if (_apiKey == 'YOUR_API_KEY') {
      throw Exception('Please provide a valid NewsAPI key in lib/services/news_service.dart');
    }

    if (categories.isEmpty) {
      return _fetchHeadlinesForCategory('general');
    }

    // Fetch headlines for all selected categories in parallel
    final futures = categories.map((cat) => _fetchHeadlinesForCategory(cat.toLowerCase()));
    final results = await Future.wait(futures);

    // Flatten the list of lists into a single list
    final allArticles = results.expand((element) => element).toList();
    
    // Shuffle the combined list to mix categories
    allArticles.shuffle();
    
    return allArticles;
  }

  static Future<List<Article>> _fetchHeadlinesForCategory(String category) async {
    // Map our categories to NewsAPI categories if needed
    // NewsAPI categories: business, entertainment, general, health, science, sports, technology
    String apiCategory = category;
    if (category == 'tech') apiCategory = 'technology';
    if (category == 'sport') apiCategory = 'sports';
    if (category == 'art') apiCategory = 'general'; // Art isn't directly supported, fallback to general or entertainment

    final url = Uri.parse('$_baseUrl/top-headlines?category=$apiCategory&language=en&pageSize=10&apiKey=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articlesJson = data['articles'] ?? [];

        return articlesJson
            .where((json) => json['title'] != '[Removed]') // Filter out removed articles
            .map((json) => Article.fromJson(json, category))
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Article>> searchNews(String query) async {
    if (_apiKey == 'YOUR_API_KEY') {
      throw Exception('Please provide a valid NewsAPI key in lib/services/news_service.dart');
    }

    final url = Uri.parse('$_baseUrl/everything?q=${Uri.encodeComponent(query)}&language=en&sortBy=publishedAt&pageSize=20&apiKey=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articlesJson = data['articles'] ?? [];

        return articlesJson
            .where((json) => json['title'] != '[Removed]')
            .map((json) => Article.fromJson(json, 'Search'))
            .toList();
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
