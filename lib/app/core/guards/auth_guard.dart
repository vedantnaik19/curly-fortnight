import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_fin_notes/app/core/services/auth_service.dart';

class AuthGuard extends GetMiddleware {
  final priority;

  AuthGuard({@required this.priority}) {
    super.priority = priority;
  }

  @override
  RouteSettings redirect(String route) {
    final authService = Get.find<AuthService>();
    return authService.isAuthed ? null : RouteSettings(name: '/login');
  }
}
