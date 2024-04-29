import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/pages/auth/pages/registration.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/widget/auth/login_form.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Вход в систему',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const LoginForm(),
        const SizedBox(
          height: 52,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                    return const RegistrationScreen();
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPaper),
            child: Text('Регистрация',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.textPrimary)),
          ),
        ),
      ],
    );
  }
}
