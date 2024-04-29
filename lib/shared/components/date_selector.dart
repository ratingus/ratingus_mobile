import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

// TODO: мб переписать на swiper
class DateSelector extends StatefulWidget {
  final void Function()? next;
  final void Function()? prev;
  final void Function(DateTime)? set;
  final DateTime selectedDate;
  final Widget Function({required DateTime selectedDate}) renderSelectDate;

  const DateSelector({
    super.key,
    this.next,
    this.prev,
    this.set,
    required this.selectedDate,
    required this.renderSelectDate,
  });

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime academicStart;

  @override
  void initState() {
    super.initState();
    academicStart = getAcademicDate(widget.selectedDate);
  }

  void selectDate(BuildContext context) async {
    final date = await showDatePicker(
      locale: const Locale("ru", "RU"),
      context: context,
      initialDate: widget.selectedDate,
      firstDate: academicStart,
      lastDate: academicStart.add(const Duration(days: 365 - 7)),
    );
    if (date != null) {
      setState(() {
        widget.set?.call(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: arrowCircleLeft,
          onPressed: widget.prev ?? () {},
        ),
        TextButton(
          onPressed: () => selectDate(context),
          child: widget.renderSelectDate(selectedDate: widget.selectedDate),
        ),
        IconButton(
          icon: arrowCircleRight,
          onPressed: widget.next ?? () {},
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
