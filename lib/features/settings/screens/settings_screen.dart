import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/general/general_cubit.dart';
import '../../../../core/localization/localization_helper.dart';
import 'language_screen.dart';

/// الإعدادات: الوضع الداكن واللغة باستخدام GeneralCubit و LocalizationHelper.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<GeneralCubit>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          BlocBuilder<GeneralCubit, dynamic>(
            buildWhen: (p, c) => c is GeneralChangeAppTheme,
            builder: (context, state) {
              return SwitchListTile(
                title: Text(l10n.darkMode),
                value: !cubit.isLightMode,
                onChanged: (_) => cubit.changeAppTheme(),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.language),
            subtitle: Text(LocalizationHelper.currentLocalName),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const LanguageScreen())),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.aboutApp),
            subtitle: Text('${l10n.appName} - ${l10n.version} 1.0.0'),
          ),
        ],
      ),
    );
  }
}
