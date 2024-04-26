import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class PressedIconButton extends StatefulWidget {
  final SvgPicture icon;
  final SvgPicture activeIcon;
  final Function()? onPressed;

  const PressedIconButton(
      {super.key,
      required this.icon,
      required this.activeIcon,
      this.onPressed});

  @override
  State<PressedIconButton> createState() => _PressedIconButtonState();
}

class _PressedIconButtonState extends State<PressedIconButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(const Size(64, 32)),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.backgroundMain),
        ),
        onPressed: () {
          setState(() {
            pressed = true;
          });
          widget.onPressed?.call();
          Future.delayed(const Duration(milliseconds: 150), () {
            setState(() {
              pressed = false;
            });
          });
        },
        child: pressed ? widget.activeIcon : widget.icon);
  }
}
