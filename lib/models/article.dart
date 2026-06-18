class NewsCategory {
  final String id;
  final String title;
  final int iconCodePoint;

  const NewsCategory({
    required this.id,
    required this.title,
    required this.iconCodePoint,
  });
}

class Article {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;
  final String author;
  final DateTime publishedAt;
  final String categoryId;
  final int readTimeMinutes;

  const Article({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    required this.categoryId,
    required this.readTimeMinutes,
  });

  factory Article.fromJson(Map<String, dynamic> json, String category) {
    final title = json['title'] as String? ?? 'No title';
    final description = json['description'] as String? ?? '';
    final content = json['content'] as String? ?? description;
    
    // Estimate read time: average reading speed is ~200 words per minute
    final wordCount = content.split(RegExp(r'\s+')).length;
    final estimatedReadTime = (wordCount / 200).ceil();

    return Article(
      id: json['url'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      excerpt: description.isNotEmpty ? description : title,
      content: content,
      imageUrl: json['urlToImage'] as String? ?? 'https://via.placeholder.com/400x200.png?text=No+Image',
      author: json['author'] as String? ?? json['source']?['name'] as String? ?? 'Unknown Author',
      publishedAt: json['publishedAt'] != null 
          ? DateTime.tryParse(json['publishedAt']) ?? DateTime.now() 
          : DateTime.now(),
      categoryId: category,
      readTimeMinutes: estimatedReadTime > 0 ? estimatedReadTime : 1,
    );
  }

  factory Article.fromSavedJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      excerpt: json['excerpt'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      author: json['author'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      categoryId: json['categoryId'] as String,
      readTimeMinutes: json['readTimeMinutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'content': content,
      'imageUrl': imageUrl,
      'author': author,
      'publishedAt': publishedAt.toIso8601String(),
      'categoryId': categoryId,
      'readTimeMinutes': readTimeMinutes,
    };
  }
}
