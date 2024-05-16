import 'package:flutter/material.dart';
import 'package:news_app/core/routing/app_router.dart';
import 'package:news_app/news_app.dart';

import 'core/di/dependency_injection.dart';

void main() {
  setupGetIt();
  runApp(NewsApp(
    appRouter: AppRouter(),
  ));
}
