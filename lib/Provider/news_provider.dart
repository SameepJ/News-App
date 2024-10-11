import 'package:flutter/material.dart';
import '../Model/article_model.dart';
import '../repositories/news_repo.dart'; // Import the news repository

class NewsProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  final NewsRepository _newsRepository = NewsRepository(); // Instance of NewsRepository

  // Getters
  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch news from repository
  Future<void> fetchNews(String countryCode) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _articles = await _newsRepository.fetchNews(countryCode);
      _isLoading = false;

      // If no articles are found, display an error message
      if (_articles.isEmpty) {
        _errorMessage = "No articles found.";
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Failed to fetch news: ${e.toString()}";
    }

    notifyListeners(); // Notify listeners to update the UI
  }
}
