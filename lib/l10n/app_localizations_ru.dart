// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'The Daily Press';

  @override
  String get welcomeTitle => 'Добро пожаловать!';

  @override
  String get welcomeSubtitle => 'Выберите интересные вам темы';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get selectCategoryWarning =>
      'Пожалуйста, выберите хотя бы одну категорию';

  @override
  String get home => 'Главная';

  @override
  String get discover => 'Обзор';

  @override
  String get saved => 'Сохраненные';

  @override
  String get latestNews => 'Последние новости';

  @override
  String get searchHint => 'Поиск новостей, тем...';

  @override
  String get browseCategories => 'Категории';

  @override
  String get searchResults => 'Результаты поиска';

  @override
  String get noArticlesFound => 'Статьи не найдены.';

  @override
  String noSearchResults(String query) {
    return 'По запросу \"$query\" ничего не найдено';
  }

  @override
  String get savedArticles => 'Сохраненные статьи';

  @override
  String get noSavedArticles => 'Пока нет сохраненных статей.';

  @override
  String get removedFromSaved => 'Удалено из сохраненных';

  @override
  String get savedToBookmarks => 'Сохранено в закладки';

  @override
  String get failedToLoadNews => 'Не удалось загрузить новости';

  @override
  String minRead(int minutes) {
    return '$minutes мин. чтения';
  }

  @override
  String get catTech => 'Технологии';

  @override
  String get catSport => 'Спорт';

  @override
  String get catHealth => 'Здоровье';

  @override
  String get catBusiness => 'Бизнес';

  @override
  String get catFinance => 'Финансы';

  @override
  String get catScience => 'Наука';

  @override
  String get catEntertainment => 'Развлечения';

  @override
  String get catArt => 'Искусство';

  @override
  String get categorySelectionHint =>
      'Рекомендуется выбрать как минимум 3 категории.';
}
