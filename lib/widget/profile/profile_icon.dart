import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

class ProfileIcon extends StatelessWidget {
  final int size;

  const ProfileIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: SizedBox(
        width: size.toDouble(),
        height: size.toDouble(),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(size.toDouble()),
            border: Border.all(
              color: Colors.black,
              width: 4,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(size / 4.0),
            child: noImageIcon,
          ),
        ),
      ),
    );
  }
}
