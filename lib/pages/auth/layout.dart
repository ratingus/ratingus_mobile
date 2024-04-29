import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

bool isAuthorized = false;

@RoutePage()
class AuthWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}