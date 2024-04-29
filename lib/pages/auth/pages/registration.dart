import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/pages/auth/layout.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

@RoutePage()
class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                isAuthorized = true;

                context.pushRoute(const LayoutRoute());
              },
              child: const Text('Зарегистрироваться'))),
    );
  }
}