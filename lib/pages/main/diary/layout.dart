import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/pages/main/diary/pages/diary_provider.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';

@RoutePage()
class DiaryWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  const DiaryWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiaryProvider(GetIt.I<AbstractLessonRepo>()),
      child: this,
    );
  }
}