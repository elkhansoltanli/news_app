import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:news_app/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/bookmark_provider.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.savedArticles,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.background,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppTheme.outlineVariant, height: 1.0),
        ),
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, provider, child) {
          final savedArticles = provider.savedArticles;

          if (savedArticles.isEmpty) {
            return Center(
              child: Text(
                l10n.noSavedArticles,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.onBackground.withValues(alpha: 0.6),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: savedArticles.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: AppTheme.outlineVariant),
            ),
            itemBuilder: (context, index) {
              final article = savedArticles[index];
              return Dismissible(
                key: Key(article.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24.0),
                  color: Colors.red.shade400,
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                onDismissed: (direction) {
                  provider.toggleBookmark(article);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.removedFromSaved),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: ArticleCard(
                  article: article,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticleScreen(article: article),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
