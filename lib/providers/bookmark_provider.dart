import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class BookmarkProvider extends ChangeNotifier {
  static const String _storageKey = 'saved_articles';
  
  List<Article> _savedArticles = [];
  List<Article> get savedArticles => _savedArticles;

  BookmarkProvider() {
    _loadFromPrefs();
  }

  bool isSaved(String articleId) {
    return _savedArticles.any((article) => article.id == articleId);
  }

  void toggleBookmark(Article article) {
    if (isSaved(article.id)) {
      _savedArticles.removeWhere((a) => a.id == article.id);
    } else {
      _savedArticles.add(article);
    }
    notifyListeners();
    _saveToPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonString = prefs.getString(_storageKey);
      
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        _savedArticles = jsonList.map((json) => Article.fromSavedJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading bookmarks: $e');
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String jsonString = jsonEncode(_savedArticles.map((a) => a.toJson()).toList());
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      debugPrint('Error saving bookmarks: $e');
    }
  }
}
