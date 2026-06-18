// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get appTitle => 'The Daily Press';

  @override
  String get welcomeTitle => 'Xoş gəldiniz!';

  @override
  String get welcomeSubtitle => 'Sizə maraqlı olan mövzuları seçin';

  @override
  String get continueButton => 'Davam et';

  @override
  String get selectCategoryWarning =>
      'Davam etmək üçün ən azı bir kateqoriya seçin';

  @override
  String get home => 'Əsas';

  @override
  String get discover => 'Kəşf et';

  @override
  String get saved => 'Yadda saxlanılanlar';

  @override
  String get latestNews => 'Son Xəbərlər';

  @override
  String get searchHint => 'Xəbərlər, mövzular axtar...';

  @override
  String get browseCategories => 'Kateqoriyalara Bax';

  @override
  String get searchResults => 'Axtarış Nəticələri';

  @override
  String get noArticlesFound => 'Məqalə tapılmadı.';

  @override
  String noSearchResults(String query) {
    return '\"$query\" üçün məqalə tapılmadı';
  }

  @override
  String get savedArticles => 'Yadda Saxlanılan Məqalələr';

  @override
  String get noSavedArticles => 'Hələ yadda saxlanılan məqalə yoxdur.';

  @override
  String get removedFromSaved => 'Yadda saxlanılanlardan silindi';

  @override
  String get savedToBookmarks => 'Yadda saxlanıldı';

  @override
  String get failedToLoadNews => 'Xəbərləri yükləmək mümkün olmadı';

  @override
  String minRead(int minutes) {
    return '$minutes dəq oxuma';
  }

  @override
  String get catTech => 'Texnologiya';

  @override
  String get catSport => 'İdman';

  @override
  String get catHealth => 'Sağlamlıq';

  @override
  String get catBusiness => 'Biznes';

  @override
  String get catFinance => 'Maliyyə';

  @override
  String get catScience => 'Elm';

  @override
  String get catEntertainment => 'Əyləncə';

  @override
  String get catArt => 'İncəsənət';

  @override
  String get categorySelectionHint =>
      'Ən azı 3 kateqoriya seçməyiniz tövsiyə olunur.';
}
