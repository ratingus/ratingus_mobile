
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/user/model/edit_profile_dto.dart';
import 'package:ratingus_mobile/entity/user/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/widget/auth/registration_form.dart';

class EditProfileModal extends StatefulWidget {
  final EditProfileDto editProfileDto;
  final Future<void> Function() refreshUser;

  const EditProfileModal({super.key, required this.editProfileDto, required this.refreshUser});

  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  late TextEditingController surnameController;
  late TextEditingController nameController;
  late TextEditingController patronymicController;
  late TextEditingController _dateController;
  final DateFormat _dateFormatter = DateFormat('dd MMM yyyy', 'ru');
  final api = GetIt.I<Api>();
  final profileRepo = GetIt.I<AbstractProfileRepo>();

  @override
  void initState() {
    super.initState();

    // Инициализируем контроллеры с начальными значениями
    surnameController =
        TextEditingController(text: widget.editProfileDto.surname);
    nameController = TextEditingController(text: widget.editProfileDto.name);
    patronymicController =
        TextEditingController(text: widget.editProfileDto.patronymic);
    _dateController = TextEditingController(
      text: widget.editProfileDto.birthDate != null
          ? DateFormat('d MMM yyyy', 'ru').format(
          DateTime.parse(widget.editProfileDto.birthDate!))
          : '',
    );
  }

  @override
  void dispose() {
    // Освобождаем контроллеры
    surnameController.dispose();
    nameController.dispose();
    patronymicController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  DateTime? getSelectedDate() {
    try {
      return _dateFormatter.parse(_dateController.text);
    } catch (e) {
      return null;
    }
  }


  Future<void> _selectDate(String? birthdate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('ru', 'RU'),
      initialDate: birthdate != null
          ? DateTime.tryParse(birthdate)
          : getSelectedDate() ??
          DateTime.now().subtract(const Duration(days: 365 * 7)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 4)),
    );
    if (picked != null) {
      _dateController.text = _dateFormatter.format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Text(
                'Профиль',
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium,
              ),
              const SizedBox(height: 10),
              buildTextFormField(
                controller: surnameController,
                labelText: 'Фамилия',
              ),
              const SizedBox(height: 10),
              buildTextFormField(
                controller: nameController,
                labelText: 'Имя',
              ),
              const SizedBox(height: 10),
              buildTextFormField(
                controller: patronymicController,
                labelText: 'Отчество',
              ),
              const SizedBox(height: 10),
              buildTextFormField(
                readOnly: true,
                controller: _dateController,
                labelText: 'Дата рождения',
                suffixIcon: InkWell(
                  onTap: () => _selectDate(widget.editProfileDto.birthDate),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.textHelper,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryMain,
                ),
                onPressed: () async {
                  String name = nameController.text.trim();
                  String surname = surnameController.text.trim();
                  String patronymic = patronymicController.text.trim();
                  String? birthDate = _dateController.text == '' ? null : () {
                    DateFormat format = DateFormat('d MMM yyyy', 'ru');
                    DateTime date = format.parse(_dateController.text);
                    return date.toIso8601String();
                  }();

                  if (name.isEmpty || surname.isEmpty || birthDate == null ||
                      birthDate.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Имя, фамилия и дата рождения не могут быть пустыми"),
                      ));
                    });
                    return;
                  }

                  try {
                    await profileRepo.editProfile(EditProfileDto(
                      birthDate: birthDate,
                      name: name,
                      surname: surname,
                      patronymic: patronymic,
                    ));

                    await widget.refreshUser();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Профиль успешно изменён"),
                      ));
                      Navigator.pop(context);
                    });
                  } catch (e) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Что-то пошло не так"),
                      ));
                    });
                  }
                },
                child: Text(
                  'Изменить',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    color: AppColors.primaryPaper,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryPaper,
                ),
                onPressed: () {
                  api.logout();
                  Navigator.pop(context);
                },
                child: Text(
                  'Выйти',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}