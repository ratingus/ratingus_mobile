import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/school/mock/schools.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';
import 'package:ratingus_mobile/shared/components/custom_modal.dart';
import 'package:ratingus_mobile/shared/components/pressed_button.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/auth/registration_form.dart';
import 'package:ratingus_mobile/widget/profile/profile_icon.dart';
import 'package:ratingus_mobile/widget/school/tab_school.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _showCodeModal(BuildContext context) {
    Navigator.of(context).push(CustomModal(
      content: Padding(
        padding:
            const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text(
                  'Код приглашения',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                    onChanged: (value) {}, labelText: 'Введите код'),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryMain,
              ),
              onPressed: () {
                AppMetrica.reportEvent('Введён код организации');
                Navigator.pop(context);
              },
              child: Text(
                'Ввести код',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryPaper,
                    ),
              ),
            ),
          ],
        ),
      ),
    ));
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
  void initState() {
    super.initState();
  }

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

  void _showEditModal(BuildContext context) {
    Navigator.of(context).push(CustomModal(
      content: Padding(
        padding:
            const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text(
                  'Профиль',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(onChanged: (value) {}, labelText: 'Фамилия'),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(onChanged: (value) {}, labelText: 'Имя'),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                    onChanged: (value) {}, labelText: 'Отчество'),
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
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryMain,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Изменить',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryPaper,
                    ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var user = currentUser;
    var schoolList = schools;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image:
                      AssetImage("assets/images/profile_empty_back_image.png"),
                  height: 180,
                  fit: BoxFit.fitHeight,
                )
              ]),
          Positioned(
              top: 180 - 20,
              left: 0,
              right: 0,
              bottom: 2,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PressedIconButton(
                            onPressed: () {
                              AppMetrica.reportEvent(
                                  'Нажата кнопка "Ввести код"');
                              _showCodeModal(context);
                            },
                            icon: addUserIcon,
                            activeIcon: activeAddUserIcon,
                          ),
                          PressedIconButton(
                            onPressed: () {
                              _showEditModal(context);
                            },
                            icon: settingsIcon,
                            activeIcon: activeSettingsIcon,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 0,
                            ),
                            child: const Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -128 - 12,
                                  left: 0,
                                  right: 0,
                                  child: ProfileIcon(size: 128),
                                ),
                              ],
                            ))),
                    Flexible(
                      flex: 30,
                      child: Column(
                        children: [
                          Text(
                            user.login,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                          Text(
                            user.getFio(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                          Text(
                            DateFormat('d MMM yyyy', 'ru')
                                .format(user.birthdate)
                                .toLowerCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.textHelper),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SchoolTabs(schools: schoolList),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
