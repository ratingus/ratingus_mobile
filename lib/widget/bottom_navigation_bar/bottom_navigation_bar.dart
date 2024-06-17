import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

import 'bottom_navigation_bar_viewmodel.dart';

class RatingusBottomNavigationBar extends StatefulWidget {
  final void Function(int, {bool notify}) onTap;

  const RatingusBottomNavigationBar({super.key, required this.onTap});

  @override
  State<RatingusBottomNavigationBar> createState() =>
      _RatingusBottomNavigationBarState();
}

class _RatingusBottomNavigationBarState
    extends State<RatingusBottomNavigationBar> {
  late final BottomNavigationBarViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = BottomNavigationBarViewModel(GetIt.I<TokenNotifier>(), GetIt.I<Api>());
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        surfaceTintColor: AppColors.backgroundPaper,
        height: 60,
        child: SizedBox(
          child: ValueListenableBuilder<UserRole>(
            valueListenable: viewModel.role,
            builder: (BuildContext context, UserRole role, Widget? child) {
              return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)),
                        ),
                        onPressed: () {
                          AppMetrica.reportEvent('Посещение объявлений');
                          widget.onTap(0);
                        },
                        child: Column(
                          children: [
                            announcementIcon,
                            const Text('Объявления',
                                style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.backgroundMain,
                        width: 1,
                      ),
                      if (role.value == UserRole.student.value)
                      ...[
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)),
                          ),
                          onPressed: () {
                            AppMetrica.reportEvent('Посещение дневника');
                            widget.onTap(1);
                          },
                          child: Column(
                            children: [
                              diaryIcon,
                              const Text('Дневник',
                                  style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                          color: AppColors.backgroundMain,
                          width: 1,
                        )
                      ],
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0)),
                        ),
                        onPressed: () {
                          AppMetrica.reportEvent('Посещение расписания');
                          widget.onTap(2);
                        },
                        child: Column(
                          children: [
                            calendarIcon,
                            const Text('Расписание',
                                style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.backgroundMain,
                        width: 1,
                      ),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0)),
                      ),
                      onPressed: () {
                        AppMetrica.reportEvent('Посещение профиля');
                        widget.onTap(3);
                      },
                      child: Column(
                        children: [
                          profileIcon,
                          const Text('Профиль',
                              style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    )
                  ]);
            },
          ),
        ));
  }
}
