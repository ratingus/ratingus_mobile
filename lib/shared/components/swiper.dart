import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

class Swiper<T> extends StatelessWidget {
  final void Function()? next;
  final void Function()? prev;
  final void Function(T)? set;
  final T Function(T) selectValue;
  final T selectedValue;
  final Widget Function(T) renderSelectedValue;

  const Swiper({
    super.key,
    this.next,
    this.prev,
    this.set,
    required this.selectedValue,
    required this.renderSelectedValue,
    required this.selectValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: arrowCircleLeft,
          onPressed: () {
            prev?.call();
          },
        ),
        TextButton(
          onPressed: () => selectValue(selectedValue),
          child: renderSelectedValue(selectedValue),
        ),
        IconButton(
          icon: arrowCircleRight,
          onPressed: () {
            next?.call();
          },
        ),
      ],
    );
  }
}
