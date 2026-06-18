import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:news_app/l10n/generated/app_localizations.dart';
import '../data/mock_data.dart';
import '../models/article.dart';
import '../services/news_service.dart';
import '../widgets/article_card.dart';
import 'article_screen.dart';
import 'category_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  Future<List<Article>>? _searchResults;

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = null;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = NewsService.searchNews(query.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.discover,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onSubmitted: _performSearch,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.onBackground.withValues(alpha: 0.5),
                ),
                prefixIcon: const Icon(Icons.search, color: AppTheme.primary),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppTheme.onBackground),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 32),
            
            if (!_isSearching) ...[
              Text(
                l10n.browseCategories,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                itemCount: mockCategories.length,
                itemBuilder: (context, index) {
                  final cat = mockCategories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoryScreen(category: cat),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        border: Border.all(color: AppTheme.outlineVariant),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(IconData(cat.iconCodePoint, fontFamily: 'MaterialIcons'), color: AppTheme.primary, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _getLocalizedCategoryTitle(cat.id, l10n).toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ] else ...[
              Text(
                l10n.searchResults,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Article>>(
                future: _searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Failed to search: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final articles = snapshot.data;
                  if (articles == null || articles.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          l10n.noSearchResults(_searchController.text),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.onBackground.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
            ],
          ],
        ),
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
