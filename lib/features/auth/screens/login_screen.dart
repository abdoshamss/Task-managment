import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/edit_text_widget.dart';
import '../../../core/utils/validators.dart';
import '../../tasks/screens/layout_screen.dart';
import '../cubit/firebase_auth_cubit.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<FirebaseAuthCubit>();
    final l10n = AppLocalizations.of(context);

    final ok = await auth.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const TaskFlowLayoutScreen()),
        (_) => false,
      );
    } else {
      final state = auth.state;
      if (state is FirebaseAuthError) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    l10n.login,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    l10n.appName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: TextFormFieldWidget(
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
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 400),
                  child: TextFormFieldWidget(
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
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 500),
                  child: BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
                    buildWhen: (p, c) =>
                        c is FirebaseAuthLoading || p is FirebaseAuthLoading,
                    builder: (context, state) {
                      return ButtonWidget(
                        title: l10n.login,
                        onTap: state is FirebaseAuthLoading ? null : _login,
                        child: state is FirebaseAuthLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.dontHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(l10n.register),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
