import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/pages/auth/layout.dart';
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
  DateTime? birthDate;
  String? login;
  String? password;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  final _buildValidator = (String fieldName) => (String? value) {
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
    if (login == 'Логин' && password == 'admin') {
      isAuthorized = true;
      context.router.popAndPush(const LayoutRoute());
    } else {
      setState(() {
        errorMessage = 'Не удалось зарегистрироваться';
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
            _buildTextFormField(
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
            _buildTextFormField(
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
            _buildTextFormField(
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
            _buildTextFormField(
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
            _buildTextFormField(
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
            _buildTextFormField(
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

_buildTextFormField({
  validator,
  void Function(String)? onChanged,
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