import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/user/model/edit_profile_dto.dart';
import 'package:ratingus_mobile/entity/user/model/jwt.dart';
import 'package:ratingus_mobile/entity/user/model/profile_dto.dart';
import 'package:ratingus_mobile/entity/user/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/components/custom_modal.dart';
import 'package:ratingus_mobile/shared/components/pressed_button.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/auth/registration_form.dart';
import 'package:ratingus_mobile/widget/edit_profile_modal/edit_profile_modal.dart';
import 'package:ratingus_mobile/widget/profile/profile_icon.dart';
import 'package:ratingus_mobile/widget/school/tab_school.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TokenNotifier _tokenNotifier;
  final profileRepo = GetIt.I<AbstractProfileRepo>();
  String code = "";
  final _dateController = TextEditingController();
  final api = GetIt.I<Api>();
  final DateFormat _dateFormatter = DateFormat('dd MMM yyyy', 'ru');
  late Future<ProfileDto> _profileDto;

  DateTime? getSelectedDate() {
    try {
      return _dateFormatter.parse(_dateController.text);
    } catch (e) {
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    _profileDto = _fetchUser();
    _tokenNotifier = GetIt.I<TokenNotifier>();
    _tokenNotifier.addListener(_onTokenChanged);
  }

  void _onTokenChanged() {
    setState(() {
      _profileDto = _fetchUser();
    });
  }

  Future<ProfileDto> _fetchUser() async {
    return await profileRepo.getProfile();
  }

  Future<void> _refreshUser() async {
    setState(() {
      _profileDto = _fetchUser();
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    _tokenNotifier.removeListener(_onTokenChanged);
    super.dispose();
  }

  void _showCodeModal(BuildContext context) {
    handleSubmit(BuildContext context) async {
      AppMetrica.reportEvent('Введён код организации');
      try {
        AppMetrica.reportEvent(
            'Отправлен запрос на подключение пользователя к организации');
        await profileRepo.enterCode(code);
        AppMetrica.reportEvent('Пользователь добавлен в организацию');
        await _refreshUser();
        JWT jwt = await api.decodeToken();
        _tokenNotifier.value = jwt;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Вы добавлены в новую школу"),
          ));
        });
      } catch (e) {
        debugPrint('Error: $e');
        AppMetrica.reportEvent(
            'Ошибка при добавлении пользователя в организацию');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Произошла ошибка при добавлении в организацию"),
          ));
        });
      }
    }

    var changeCodeModal = CustomModal(
      content: (BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
        child: Form(
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
                      onFieldSubmitted: (value) {
                        handleSubmit(context);
                      },
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                      labelText: 'Введите код'),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryMain,
                ),
                onPressed: () => handleSubmit(context),
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
      ),
    );

    Navigator.of(context).push(changeCodeModal);
  }

  void _showEditModal(BuildContext context, EditProfileDto editProfileDto) {
    Navigator.of(context).push(
      CustomModal(
        content: (BuildContext context) => EditProfileModal(editProfileDto: editProfileDto, refreshUser: _refreshUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _refreshUser();
      },
      child: FutureBuilder<ProfileDto>(
        future: _profileDto.timeout(const Duration(seconds: 10), onTimeout: () {
          throw TimeoutException('Превышено время ожидания');
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Данные не найдены'));
          } else {
            final profile = snapshot.data!;
            return FutureBuilder<JWT>(
              future: api.decodeToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('Данные не найдены'));
                } else {
                  final jwt = snapshot.data!;
                  return Stack(
                    children: <Widget>[
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                              "assets/images/profile_empty_back_image.png",
                            ),
                            height: 180,
                            fit: BoxFit.fitHeight,
                          ),
                        ],
                      ),
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
                                  vertical: 12,
                                  horizontal: 6,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PressedIconButton(
                                      onPressed: () {
                                        AppMetrica.reportEvent(
                                          'Нажата кнопка "Ввести код"',
                                        );
                                        _showCodeModal(context);
                                      },
                                      icon: addUserIcon,
                                      activeIcon: activeAddUserIcon,
                                    ),
                                    PressedIconButton(
                                      onPressed: () {
                                        _showEditModal(context, new EditProfileDto(
                                          name: profile.name,
                                          surname: profile.surname,
                                          patronymic: profile.patronymic,
                                          birthDate: profile.birthdate.toIso8601String(),
                                        ));
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
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 30,
                                child: Column(
                                  children: [
                                    Text(
                                      profile.login,
                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      profile.getFio(),
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      DateFormat('d MMM yyyy', 'ru').format(profile.birthdate).toLowerCase(),
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: AppColors.textHelper,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          child: SchoolTabs(
                                            schools: profile.schools,
                                            defaultSchoolId: jwt.school == null ? null : int.parse(jwt.school!),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
  }