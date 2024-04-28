import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/school/mock/schools.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';
import 'package:ratingus_mobile/shared/components/buttons/pressed_button.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/school/tab_school.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                            onPressed: () {},
                            icon: addUserIcon,
                            activeIcon: activeAddUserIcon,
                          ),
                          PressedIconButton(
                            onPressed: () {},
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
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -128 - 12,
                                  left: 0,
                                  right: 0,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: SizedBox(
                                      width: 128,
                                      height: 128,
                                      child: Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          color: AppColors.textPrimary,
                                          borderRadius:
                                              BorderRadius.circular(128),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 4,
                                            strokeAlign:
                                                BorderSide.strokeAlignInside,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(32),
                                          child: noImageIcon,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
