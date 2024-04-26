import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

class AnnouncementListItem extends StatelessWidget {
  const AnnouncementListItem({super.key, required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundMain,
          borderRadius: BorderRadius.all(Radius.elliptical(14, 16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('d MMM HH:mm', 'ru')
                        .format(announcement.date)
                        .toLowerCase(),
                    style: const TextStyle(color: AppColors.textHelper),
                  ),
                  Row(
                    children: [
                      Text(
                        announcement.views.toString(),
                        style: const TextStyle(color: AppColors.textHelper),
                      ),
                      viewIcon,
                    ],
                  )
                ],
              ),
              Text(
                announcement.fullName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.textHelper),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: announcement.classes.map((classItem) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryMain,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            classItem.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.primaryPaper),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Text(
                announcement.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              announcement.content != null
                  ? Text(
                      announcement.content!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : Container(),
            ],
          ),
        ));
    ;
  }
}
