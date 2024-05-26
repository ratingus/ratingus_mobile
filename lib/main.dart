import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:ratingus_mobile/entity/auth/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/auth/repo/http_repo.dart';
import 'package:ratingus_mobile/entity/study/repo/http_repo.dart';
import 'package:ratingus_mobile/entity/user/repo/http_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

import 'entity/class/repo/abstract_repo.dart';
import 'entity/class/repo/http_repo.dart';
import 'entity/lesson/repo/http_repo.dart';
import 'entity/study/repo/abstract_repo.dart';
import 'entity/announcement/repo/abstract_repo.dart';
import 'entity/announcement/repo/mock_repo.dart';
import 'entity/lesson/repo/abstract_repo.dart';

import 'entity/user/repo/abstract_repo.dart';
import 'shared/router/router.dart';

final _appRouter = AppRouter();

void main() async {
  await dotenv.load(fileName: "env/.env");

  AppMetrica.activate(AppMetricaConfig(dotenv.env['YA_METRICA_API_KEY']!, logs: true));
  AppMetrica.reportEvent('Пользователь открыл приложение');

  GetIt.I.registerSingleton<AppRouter>(_appRouter);

  final api = Api();
  api.init();
  GetIt.I.registerSingleton<Api>(api);

  GetIt.I.registerSingleton<AbstractProfileRepo>(HttpProfileRepo());
  GetIt.I.registerSingleton<AbstractAuthRepo>(HttpAuthRepo());
  GetIt.I.registerSingleton<AbstractAnnouncementRepo>(MockAnnouncementRepo());
  GetIt.I.registerSingleton<AbstractStudyRepo>(HttpStudyRepo());
  GetIt.I.registerSingleton<AbstractClassRepo>(HttpClassRepo());
  GetIt.I.registerSingleton<AbstractLessonRepo>(HttpLessonRepo());

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

