import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'colors.dart';

final SvgPicture diaryIcon = SvgPicture.asset('assets/icons/diary.svg');
final SvgPicture calendarIcon = SvgPicture.asset('assets/icons/calendar.svg');
final SvgPicture announcementIcon = SvgPicture.asset('assets/icons/announcement.svg');
final SvgPicture profileIcon = SvgPicture.asset('assets/icons/empty-profile.svg');

final SvgPicture viewIcon = SvgPicture.asset('assets/icons/view.svg', colorFilter: const ColorFilter.mode(AppColors.textHelper, BlendMode.srcIn));