import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/auth/model/user_register.dart';
import 'package:ratingus_mobile/entity/auth/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';


class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String? surname;
  String? name;
  String? patronymic;
  String? birthdate;
  String? login;
  String? password;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  final authRepo = GetIt.I<AbstractAuthRepo>();

  _buildValidator(String fieldName) => (String? value) {
        if (value == null || value.isEmpty) {
          return 'Заполните поле';
        } else if (value.length <= 3) {
          return 'Минимум 4 символа';
        }
        return null;
      };

  String? Function(String?) patronymicValidator = (String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length <= 3) {
      return 'Минимум 4 символа';
    }
    return null;
  };

  handleSubmit() {
    debugPrint('login: $login, password: $password');
    if (login != null && password != null) {
      authRepo
          .register(UserRegister(
        login: login!,
        password: password!,
        name: name!,
        surname: surname!,
        patronymic: patronymic!,
        birthDate: birthdate!
      ))
          .then((value) => {
      AppMetrica.reportEvent('Пользователь зарегистрировался'),
        context.router.popAndPush(const LayoutRoute())
      })
          .catchError((e) {
        setState(() {
          errorMessage = 'Не удалось зарегистрироваться';
        });
      });
    }
  }

  final _dateController = TextEditingController();

  DateTime? getSelectedDate() {
    try {
      return _dateFormatter.parse(_dateController.text);
    } catch (e) {
      return null;
    }
  }

  final _dateFormatter = DateFormat('dd MMM yyyy', 'ru');

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      initialDate: getSelectedDate() ??
          DateTime.now().subtract(const Duration(days: 365 * 7)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 6)),
    );
    if (picked != null) {
      _dateController.text = _dateFormatter.format(picked);
      setState(() {
        birthdate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(picked);
      });
    }
  }

  bool isWatchRules = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            buildTextFormField(
                validator: _buildValidator('Фамилия'),
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    surname = value;
                  });
                },
                labelText: 'Фамилия'),
            const SizedBox(
              height: 10,
            ),
            buildTextFormField(
                validator: _buildValidator('Имя'),
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    name = value;
                  });
                },
                labelText: 'Имя'),
            const SizedBox(
              height: 10,
            ),
            buildTextFormField(
                validator: patronymicValidator,
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    patronymic = value;
                  });
                },
                labelText: 'Отчество'),
            const SizedBox(
              height: 10,
            ),
            buildTextFormField(
                readOnly: true,
                controller: _dateController,
                labelText: 'Дата рождения',
                suffixIcon: InkWell(
                    onTap: _selectDate,
                    child: const Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.textHelper,
                    ))),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            buildTextFormField(
                validator: _buildValidator('Логин'),
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    login = value;
                  });
                },
                labelText: 'Логин'),
            const SizedBox(
              height: 10,
            ),
            buildTextFormField(
                validator: _buildValidator('Пароль'),
                onChanged: (value) {
                  setState(() {
                    errorMessage = null;
                    password = value;
                  });
                },
                labelText: 'Пароль',
                obscureText: !_passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.textHelper,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isWatchRules,
                        onChanged: (value) => {
                              setState(() {
                                isWatchRules = value ?? false;
                              })
                            }),
                  ),
                ),
                Expanded(
                    child: RichText(
                        maxLines: null,
                        text: TextSpan(
                          text: 'Я согласен с ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                          children: [
                            // TODO: Ссылка на пользовательское соглашение
                            TextSpan(
                              text: '“Пользовательским соглашением”',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.primaryMain,
                                  ),
                            ),
                          ],
                        )))
              ],
            ),
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
                child: Text('Регистрация',
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

buildTextFormField({
  validator,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  labelText,
  obscureText,
  suffixIcon,
  TextInputType? textInputType,
  TextInputAction? textInputAction,
  controller,
  bool? readOnly,
}) {
  return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged ?? (val) {},
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: suffixIcon,
        errorBorder: const OutlineInputBorder().copyWith(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: const BorderSide(color: AppColors.statusWarning),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        border: const OutlineInputBorder().copyWith(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        labelText: labelText,
      ));
}
