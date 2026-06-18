import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/l10n/generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../services/news_service.dart';
import '../models/article.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final Set<String>? selectedCategories;

  const HomeScreen({
    super.key,
    this.selectedCategories,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppTheme.outlineVariant,
            height: 1.0,
          ),
        ),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.appTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppTheme.background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppTheme.surfaceVariant,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/logo.svg',
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppTheme.onBackground),
              title: Text(l10n.settings, style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: AppTheme.onBackground),
              title: Text(l10n.about, style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                showAboutDialog(
                  context: context,
                  applicationName: l10n.appTitle,
                  applicationVersion: '1.0.0',
                  applicationIcon: SvgPicture.asset('assets/logo.svg', width: 48, height: 48),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future: NewsService.fetchTopHeadlines(selectedCategories ?? {}),
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

          final featuredArticle = articles.first;
          final otherArticles = articles.skip(1).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            children: [
              // Featured Article
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleScreen(article: featuredArticle),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        featuredArticle.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          width: double.infinity,
                          color: AppTheme.surfaceVariant,
                          child: const Icon(Icons.image_not_supported, size: 48, color: AppTheme.outlineVariant),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          featuredArticle.categoryId.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.primary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          l10n.minRead(featuredArticle.readTimeMinutes),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      featuredArticle.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      featuredArticle.excerpt,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: AppTheme.outlineVariant),
              const SizedBox(height: 16),
              Text(
                l10n.latestNews,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              // Other Articles
              ...otherArticles.map((article) => ArticleCard(
                article: article,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleScreen(article: article),
                    ),
                  );
                },
              )),
            ],
          );
        },
      ),
    );
  }
}
