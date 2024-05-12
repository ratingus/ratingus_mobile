import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'entity/class/repo/abstract_repo.dart';
import 'entity/class/repo/mock_repo.dart';
import 'entity/study/repo/abstract_repo.dart';
import 'entity/study/repo/mock_repo.dart';
import 'entity/announcement/repo/abstract_repo.dart';
import 'entity/announcement/repo/mock_repo.dart';
import 'entity/lesson/repo/abstract_repo.dart';
import 'entity/lesson/repo/mock_repo.dart';

import 'shared/router/router.dart';

final _appRouter = AppRouter();

void main() {
  GetIt.I.registerSingleton<AbstractAnnouncementRepo>(MockAnnouncementRepo());
  GetIt.I.registerSingleton<AbstractStudyRepo>(MockStudyRepo());
  GetIt.I.registerSingleton<AbstractClassRepo>(MockClassRepo());
  GetIt.I.registerSingleton<AbstractLessonRepo>(MockLessonRepo());

  runApp(const RatingusApp());
}

class RatingusApp extends StatefulWidget {
  const RatingusApp({super.key});

  @override
  State<StatefulWidget> createState() => _RatingusAppState();
}

class _RatingusAppState extends State<RatingusApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}

