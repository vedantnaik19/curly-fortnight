import 'package:get/get.dart';
import 'package:stack_fin_notes/app/pages/login/login_binding.dart';
import 'package:stack_fin_notes/app/pages/login/related/fogot_pass_page.dart';
import 'package:stack_fin_notes/app/pages/login/related/signup_page.dart';

import 'app/core/guards/auth_guard.dart';
import 'app/pages/home/home_binding.dart';
import 'app/pages/home/home_page.dart';
import 'app/pages/login/login_page.dart';
import 'app/pages/note_detail/note_detail_binding.dart';
import 'app/pages/note_detail/note_detail_page.dart';

class AppRoutes {
  static final pages = [
    GetPage(
        name: '/note-detail',
        page: () => NoteDetailPage(),
        binding: NoteDetailBinding(),
        middlewares: [AuthGuard(priority: 0)]),
    GetPage(
        name: '/home',
        page: () => HomePage(),
        binding: HomeBinding(),
        middlewares: [AuthGuard(priority: 0)]),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/forgot-pass',
      page: () => ForgotPassPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignUpPage(),
      binding: LoginBinding(),
    ),
  ];
}
