import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/home/data/models/artical_model.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import 'package:news_app/feature/home/ui/artical_details_screen.dart';
import 'package:news_app/feature/settings/settings_screen.dart';

import '../../feature/home/home_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case Routes.articalDetailsScreen:
        final articalItem = settings.arguments as ArticalModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: ArticalDetailsScreen(artical: articalItem),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
