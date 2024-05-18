import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

class RatingusBottomNavigationBar extends StatelessWidget {
  final void Function(int, {bool notify}) onTap;
  const RatingusBottomNavigationBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        surfaceTintColor: AppColors.backgroundPaper,
        height: 45,
        child: SizedBox(
          child: Row(
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
                    onTap(0);
                  },
                  child: announcementIcon,
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
                    AppMetrica.reportEvent('Посещение дневника');
                    onTap(1);
                  },
                  child: diaryIcon,
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
                    AppMetrica.reportEvent('Посещение расписания');
                    onTap(2);
                  },
                  child: calendarIcon,
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
                    onTap(3);
                    },
                  child: profileIcon,
                )
              ]),
        ));
  }
}
