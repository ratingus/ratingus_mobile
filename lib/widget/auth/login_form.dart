import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/model/user_login.dart';
import 'package:ratingus_mobile/entity/auth/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? login;
  String? password;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final authRepo = GetIt.I<AbstractAuthRepo>();

  String? Function(String?) usernameValidator = (String? username) {
    if (username == null || username.isEmpty) {
      return 'Логин не может быть пустым';
    } else if (username.length < 3) {
      return 'Логин должен быть длиннее 2 символов';
    }
    return null;
  };
  String? Function(String?) passwordValidator = (String? password) {
    if (password == null || password.isEmpty) {
      return 'Пароль не может быть пустым';
    } else if (password.length < 3) {
      return 'Пароль должен быть длиннее 2 символов';
    }
    return null;
  };

  handleSubmit() {
    if (login != null && password != null) {
      authRepo
          .login(UserLogin(login: login!, password: password!))
          .then((value) => {
                AppMetrica.reportEvent('Пользователь вошёл в аккаунт'),
                context.router.popAndPush(const LayoutRoute())
              })
          .catchError((e) {
        setState(() {
          errorMessage = 'Нет такого пользователя или пароль неправильный';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                validator: usernameValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    login = value;
                  });
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: const OutlineInputBorder().copyWith(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        const BorderSide(color: AppColors.statusWarning),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: const OutlineInputBorder().copyWith(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Логин',
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                validator: passwordValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: Theme.of(context).textTheme.bodySmall,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    password = value;
                  });
                },
                onFieldSubmitted: (value) {
                  handleSubmit();
                },
                decoration: InputDecoration(
                  errorBorder: const OutlineInputBorder().copyWith(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        const BorderSide(color: AppColors.statusWarning),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  border: const OutlineInputBorder().copyWith(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.textHelper,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  labelText: 'Пароль',
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMain,
                ),
                child: Text('Вход',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.primaryPaper)),
              ),
            ),
            if (errorMessage != null)
              Card(
                color: AppColors.backgroundMain,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    errorMessage!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.statusWarning),
                  ),
                ),
              ),
          ],
        ));
  }
}
