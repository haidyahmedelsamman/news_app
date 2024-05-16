import 'package:flutter/material.dart';
import 'package:news_app/core/routing/app_router.dart';
import 'package:news_app/news_app.dart';

void main() {
  runApp(NewsApp(
    appRouter: AppRouter(),
  ));
}
