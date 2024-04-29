import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/pages/auth/layout.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: Card(
          child: SizedBox(
            height: 260,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text('Вход в систему', style: Theme.of(context).textTheme.displayMedium,),
                  ElevatedButton(
                      onPressed: () {
                        isAuthorized = true;

                        context.pushRoute(const LayoutRoute());
                      },
                      child: const Text('Войти'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
