import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../cubit/firebase_auth_cubit.dart';
import '../../tasks/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _localize(AppLocalizations l10n, String key) {
    switch (key) {
      case 'emailNotFound':
        return l10n.emailNotFound;
      case 'wrongPassword':
        return l10n.wrongPassword;
      case 'emailAlreadyInUse':
        return l10n.emailAlreadyInUse;
      case 'passwordTooWeak':
        return l10n.passwordTooWeak;
      case 'checkInternet':
        return l10n.checkInternet;
      case 'permissionDenied':
        return l10n.permissionDenied;
      case 'unknownError':
        return l10n.unknownError;
      default:
        return key;
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<FirebaseAuthCubit>();

    final ok = await auth.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const TaskFlowHomeScreen()),
        (_) => false,
      );
    } else {
      final state = auth.state;
      if (state is FirebaseAuthError) {
        final l10n = AppLocalizations.of(context);
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
      appBar: AppBar(title: Text(l10n.register)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(24),
                TextFormFieldWidget(
                  controller: _nameController,
                  label: l10n.fullName,
                  hintText: l10n.fullName,
                  validator: (v) => Validators.required(v) != null
                      ? l10n.requiredField
                      : null,
                ),
                const Gap(16),
                TextFormFieldWidget(
                  controller: _emailController,
                  label: l10n.email,
                  hintText: l10n.email,
                  type: TextInputType.emailAddress,
                  validator: (v) {
                    final r = Validators.required(v);
                    if (r != null) return l10n.requiredEmail;
                    final e = Validators.email(v);
                    if (e != null) return l10n.wrongEmailValidation;
                    return null;
                  },
                ),
                const Gap(16),
                TextFormFieldWidget(
                  controller: _passwordController,
                  label: l10n.password,
                  hintText: l10n.password,
                  password: true,
                  validator: (v) {
                    final r = Validators.password(v);
                    if (r == 'requiredPassword') return l10n.requiredPassword;
                    if (r == 'smallPassword') return l10n.smallPassword;
                    return null;
                  },
                ),
                const Gap(16),
                TextFormFieldWidget(
                  controller: _confirmPasswordController,
                  label: l10n.confirmPasswordLabel,
                  hintText: l10n.confirmPasswordLabel,
                  password: true,
                  validator: (v) {
                    final r = Validators.confirmPassword(
                      v,
                      _passwordController.text,
                    );
                    if (r == 'requiredPassword') return l10n.requiredPassword;
                    if (r == 'passwordNotMatch') return l10n.passwordNotMatch;
                    return null;
                  },
                ),
                const Gap(32),
                BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
                  buildWhen: (p, c) =>
                      c is FirebaseAuthLoading || p is FirebaseAuthLoading,
                  builder: (context, state) {
                    final loading = state is FirebaseAuthLoading;
                    return ButtonWidget(
                      title: l10n.register,
                      onTap: loading ? null : _register,
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
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.alreadyHaveAccount),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.login),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
