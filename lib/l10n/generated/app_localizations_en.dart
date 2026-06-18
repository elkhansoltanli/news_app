// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'The Daily Press';

  @override
  String get welcomeTitle => 'Welcome!';

  @override
  String get welcomeSubtitle => 'Choose topics that interest you';

  @override
  String get continueButton => 'Continue';

  @override
  String get selectCategoryWarning =>
      'Please select at least one category to continue';

  @override
  String get home => 'Home';

  @override
  String get discover => 'Discover';

  @override
  String get saved => 'Saved';

  @override
  String get latestNews => 'Latest News';

  @override
  String get searchHint => 'Search for news, topics...';

  @override
  String get browseCategories => 'Browse Categories';

  @override
  String get searchResults => 'Search Results';

  @override
  String get noArticlesFound => 'No articles found.';

  @override
  String noSearchResults(String query) {
    return 'No articles found for \"$query\"';
  }

  @override
  String get savedArticles => 'Saved Articles';

  @override
  String get noSavedArticles => 'No saved articles yet.';

  @override
  String get removedFromSaved => 'Removed from saved';

  @override
  String get savedToBookmarks => 'Saved to bookmarks';

  @override
  String get failedToLoadNews => 'Failed to load news';

  @override
  String minRead(int minutes) {
    return '$minutes min read';
  }

  @override
  String get catTech => 'Tech';

  @override
  String get catSport => 'Sport';

  @override
  String get catHealth => 'Health';

  @override
  String get catBusiness => 'Business';

  @override
  String get catFinance => 'Finance';

  @override
  String get catScience => 'Science';

  @override
  String get catEntertainment => 'Entertainment';

  @override
  String get catArt => 'Art';

  @override
  String get categorySelectionHint =>
      'It is recommended to select at least 3 categories.';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get notifications => 'Notifications';

  @override
  String get about => 'About';
}
