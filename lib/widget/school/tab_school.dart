import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/class/ui/class_item.dart';
import 'package:ratingus_mobile/entity/school/model/school.dart';
import 'package:ratingus_mobile/entity/user/model/jwt.dart';
import 'package:ratingus_mobile/entity/user/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class SchoolTabs extends StatefulWidget {
  final List<School> schools;
  final int defaultSchoolId;

  const SchoolTabs({super.key, required this.schools, required this.defaultSchoolId});

  @override
  State<SchoolTabs> createState() => _SchoolTabsState();
}

class _SchoolTabsState extends State<SchoolTabs>
    with SingleTickerProviderStateMixin {
  late final TokenNotifier _tokenNotifier;
  late int _selectedSchoolIndex;
  final profileRepo = GetIt.I<AbstractProfileRepo>();
  final api = GetIt.I<Api>();

  @override
  void initState() {
    super.initState();
    _selectedSchoolIndex = widget.schools.indexWhere((school) => school.id == widget.defaultSchoolId);
    if (_selectedSchoolIndex == -1) {
      _selectedSchoolIndex = 0;
    }
    _tokenNotifier = GetIt.I<TokenNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.schools.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed: () async {
                if (_selectedSchoolIndex == index) {
                  return;
                }
                setState(() {
                  _selectedSchoolIndex = index;
                });
                await profileRepo.changeSchool(widget.schools[index].id);
                JWT jwt = await api.decodeToken();
                _tokenNotifier.value = jwt;
                AppMetrica.reportEvent('Пользователь сменил школу');
              },
              child: Text(
                widget.schools[index].name,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: _selectedSchoolIndex == index
                        ? AppColors.primaryMain
                        : AppColors.textPrimary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.schools[index].role.text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            widget.schools[index].classDto != null ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.backgroundMain,
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [ClassListItem(classItem: widget.schools[index].classDto!)],
                  ),
                )) : const SizedBox(),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 13,
          color: Colors.transparent,
        );
      },
    );
  }
}
