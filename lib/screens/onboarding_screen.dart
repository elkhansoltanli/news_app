import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/l10n/generated/app_localizations.dart';
import '../theme/app_theme.dart';
import 'main_scaffold.dart';

class CategoryItem {
  final String title;
  final IconData icon;

  CategoryItem(this.title, this.icon);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<CategoryItem> categories = [
    CategoryItem('Tech', Icons.memory),
    CategoryItem('Sport', Icons.sports_soccer),
    CategoryItem('Health', Icons.health_and_safety),
    CategoryItem('Business', Icons.business_center),
    CategoryItem('Finance', Icons.payments),
    CategoryItem('Science', Icons.science),
    CategoryItem('Entertainment', Icons.movie),
    CategoryItem('Art', Icons.palette),
  ];

  final Set<String> selectedCategories = {};
  bool isLoading = false;

  void toggleCategory(String title) {
    setState(() {
      if (selectedCategories.contains(title)) {
        selectedCategories.remove(title);
      } else {
        selectedCategories.add(title);
      }
    });
  }

  void onContinue() async {
    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zəhmət olmasa ən azı bir kateqoriya seçin.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;
    
    setState(() {
      isLoading = false;
    });

    // Navigate to MainScaffold
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MainScaffold(
          selectedCategories: selectedCategories,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double progress = (selectedCategories.length / 3).clamp(0.0, 1.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppTheme.background,
          // Emulating the tailwind background radial gradients
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              Color(0x26B5C4FF), // rgba(181, 196, 255, 0.15)
              Colors.transparent,
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Progress Bar
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppTheme.surfaceContainer,
                color: AppTheme.primary,
                minHeight: 4,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header Section
                      SvgPicture.asset(
                        'assets/logo.svg',
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.welcomeTitle,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.welcomeSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.onBackground.withAlpha(204),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),

                      // Grid Section
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: categories.map((cat) {
                          final isSelected = selectedCategories.contains(cat.title);
                          return InkWell(
                            onTap: () => toggleCategory(cat.title),
                            borderRadius: BorderRadius.circular(8),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.primaryContainer : AppTheme.surfaceContainerLowest,
                                border: Border.all(
                                  color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    cat.icon,
                                    color: isSelected ? Colors.white : AppTheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    cat.title.toUpperCase(),
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: isSelected ? Colors.white : AppTheme.onBackground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.categorySelectionHint,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),

                      const Spacer(),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : onContinue,
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(l10n.continueButton),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_forward),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
