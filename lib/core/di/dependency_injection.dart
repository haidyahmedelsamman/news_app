import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import '../../feature/home/data/repos/home_repo.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio ));

  // home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));


}