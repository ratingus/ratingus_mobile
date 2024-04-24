import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/theme.dart';

import 'shared/router/router.dart';

void main() {
  runApp(const RatingusApp());
}

class RatingusApp extends StatefulWidget {
  const RatingusApp({super.key});

  @override
  State<StatefulWidget> createState() => _RatingusAppState();
}

class _RatingusAppState extends State<RatingusApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Ratingus',
      theme: appThemeData,
    );
  }
}

