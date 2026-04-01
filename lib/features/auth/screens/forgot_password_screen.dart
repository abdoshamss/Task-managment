import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../cubit/firebase_auth_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String _localize(AppLocalizations l10n, String key) {
    switch (key) {
      case 'emailNotFound':
        return l10n.emailNotFound;
      case 'checkInternet':
        return l10n.checkInternet;
      default:
        return l10n.unknownError;
    }
  }

  Future<void> _sendResetLink() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<FirebaseAuthCubit>();
    final l10n = AppLocalizations.of(context);

    final ok = await auth.forgotPassword(_emailController.text.trim());
    if (!mounted) return;

    if (ok) {
      Fluttertoast.showToast(
        msg: l10n.resetLinkSent,
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.of(context).pop();
    } else {
      final state = auth.state;
      if (state is ForgotPasswordError) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.forgotPasswordTitle),
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
                const SizedBox(height: 32),
                Icon(
                  Icons.lock_reset_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.enterEmailToReset,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormFieldWidget(
                  controller: _emailController,
                  label: l10n.email,
                  hintText: l10n.email,
                  type: TextInputType.emailAddress,
                  validator: (v) {
                    final r = Validators.required(v);
                    if (r != null) return l10n.requiredField;
                    final e = Validators.email(v);
                    if (e != null) return l10n.wrongEmailValidation;
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
                  buildWhen: (p, c) =>
                      c is ForgotPasswordLoading || p is ForgotPasswordLoading,
                  builder: (context, state) {
                    final loading = state is ForgotPasswordLoading;
                    return ButtonWidget(
                      title: l10n.sendResetLink,
                      onTap: loading ? null : _sendResetLink,
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
