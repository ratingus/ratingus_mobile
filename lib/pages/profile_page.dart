import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Профиль",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            diaryIcon,
            Text(
              'Профиль',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You have pushed the button this many times:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
