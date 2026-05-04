import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangment/core/lang_cubit/lang_cubit.dart';
import 'package:task_mangment/features/splash/presentation/screens/splash/splash.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/localization/localization_helper.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentLang = LocalizationHelper.currentLocalName;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: ListView(
          children: [
            RadioListTile<String>(
              activeColor: Theme.of(context).colorScheme.primary,
              title: Text(l10n.arabic),
              value: 'العربية',
              groupValue: currentLang,
              onChanged: (value) async {
                if (value != null && value != currentLang) {
                  //await LocalizationHelper.setLocale(value);
                  context.read<LangCubit>().changeLocale(value);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false,
                  );
                }
              },
            ),
            const Divider(),
            RadioListTile<String>(
              activeColor: Theme.of(context).colorScheme.primary,
              title: Text(l10n.english),
              value: 'English',
              groupValue: currentLang,
              onChanged: (value) async {
                if (value != null && value != currentLang) {
                  // await LocalizationHelper.setLocale(value);
                  context.read<LangCubit>().changeLocale(value);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
