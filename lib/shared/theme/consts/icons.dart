import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'colors.dart';

final SvgPicture diaryIcon = SvgPicture.asset('assets/icons/diary.svg');
final SvgPicture calendarIcon = SvgPicture.asset('assets/icons/calendar.svg');
final SvgPicture announcementIcon = SvgPicture.asset('assets/icons/announcement.svg');
final SvgPicture profileIcon = SvgPicture.asset('assets/icons/empty-profile.svg');

final SvgPicture viewIcon = SvgPicture.asset(
    'assets/icons/view.svg',
    colorFilter: const ColorFilter.mode(AppColors.textHelper, BlendMode.srcIn)
);

final SvgPicture settingsIcon = SvgPicture.asset('assets/icons/settings.svg');
final SvgPicture activeSettingsIcon = SvgPicture.asset('assets/icons/settings.svg',
    colorFilter: const ColorFilter.mode(AppColors.primaryMain, BlendMode.srcIn)
);
final SvgPicture addUserIcon = SvgPicture.asset('assets/icons/add-user.svg');
final SvgPicture activeAddUserIcon = SvgPicture.asset('assets/icons/add-user.svg',
    colorFilter: const ColorFilter.mode(AppColors.primaryMain, BlendMode.srcIn)
);

final SvgPicture noImageIcon = SvgPicture.asset('assets/icons/no-image.svg');

final SvgPicture arrowDown = SvgPicture.asset('assets/icons/arrow-down.svg',
colorFilter: const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn));

final SvgPicture arrowCircleRight = SvgPicture.asset('assets/icons/arrow-circle.svg',
    colorFilter: const ColorFilter.mode(AppColors.textHelper, BlendMode.srcIn));
final SvgPicture arrowCircleLeft = SvgPicture.asset('assets/icons/arrow-circle-left.svg',
    colorFilter: const ColorFilter.mode(AppColors.textHelper, BlendMode.srcIn));
