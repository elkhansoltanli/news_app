import 'package:flutter/material.dart';
import 'package:news_app/l10n/generated/app_localizations.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../theme/app_theme.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';

class CategoryScreen extends StatelessWidget {
  final NewsCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(IconData(category.iconCodePoint, fontFamily: 'MaterialIcons'), color: AppTheme.primary),
            const SizedBox(width: 8),
            Text(
              _getLocalizedCategoryTitle(category.id, l10n),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.background,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppTheme.outlineVariant, height: 1.0),
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future: NewsService.fetchTopHeadlines({category.id}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: AppTheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      l10n.failedToLoadNews,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final articles = snapshot.data;
          if (articles == null || articles.isEmpty) {
            return Center(child: Text(l10n.noArticlesFound));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: articles.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: AppTheme.outlineVariant),
            ),
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(
                article: article,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _getLocalizedCategoryTitle(String id, AppLocalizations l10n) {
    switch (id) {
      case 'tech': return l10n.catTech;
      case 'sport': return l10n.catSport;
      case 'health': return l10n.catHealth;
      case 'business': return l10n.catBusiness;
      case 'finance': return l10n.catFinance;
      case 'science': return l10n.catScience;
      case 'entertainment': return l10n.catEntertainment;
      case 'art': return l10n.catArt;
      default: return id;
    }
  }
}
