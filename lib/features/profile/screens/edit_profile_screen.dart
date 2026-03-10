import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../auth/cubit/firebase_auth_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<FirebaseAuthCubit>().currentUser;
    _nameController.text = user?.displayName ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _localize(AppLocalizations l10n, String key) {
    switch (key) {
      case 'checkInternet':
        return l10n.checkInternet;
      default:
        return l10n.unknownError;
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<FirebaseAuthCubit>();
    final l10n = AppLocalizations.of(context);

    final ok = await auth.updateProfile(
      displayName: _nameController.text.trim(),
    );
    if (!mounted) return;

    if (ok) {
      Fluttertoast.showToast(
        msg: l10n.profileUpdated,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.of(context).pop(true);
    } else {
      final state = auth.state;
      if (state is ProfileUpdateError) {
        Fluttertoast.showToast(
          msg: _localize(l10n, state.messageKey),
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = context.read<FirebaseAuthCubit>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editProfile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(24),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Text(
                      (user?.displayName?.isNotEmpty == true
                              ? user!.displayName!.substring(0, 1)
                              : user?.email.substring(0, 1) ?? '?')
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const Gap(24),
                TextFormFieldWidget(
                  controller: _nameController,
                  label: l10n.displayName,
                  hintText: l10n.displayName,
                  type: TextInputType.name,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l10n.requiredField;
                    }
                    return null;
                  },
                ),
                const Gap(16),
                TextFormFieldWidget(
                  controller: TextEditingController(text: user?.email ?? ''),
                  label: l10n.email,
                  hintText: l10n.email,
                  type: TextInputType.emailAddress,
                  enable: false,
                ),
                const Gap(32),
                BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
                  buildWhen: (p, c) =>
                      c is ProfileUpdateLoading || p is ProfileUpdateLoading,
                  builder: (context, state) {
                    final loading = state is ProfileUpdateLoading;
                    return ButtonWidget(
                      title: l10n.save,
                      onTap: loading ? null : _save,
                      child: loading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
