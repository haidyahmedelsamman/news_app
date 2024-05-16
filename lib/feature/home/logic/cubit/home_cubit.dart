import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/home/data/models/category_model.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';
import '../../../../core/theme/colors.dart';
import '../../data/models/artical_model.dart';
import '../../data/models/sources_title_response.dart';
import '../../data/repos/home_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(
    this._homeRepo,
  ) : super(const HomeState.initial());

  List<CategoryModel> categoryList = [
    CategoryModel(
      category: "sports",
      categoryImage: "assets/images/sports.png",
      categoryName: "Sports",
      categoryColor: ColorsManager.red,
    ),
    CategoryModel(
      category: "general",
      categoryImage: "assets/images/Politics.png",
      categoryName: "Politics",
      categoryColor: ColorsManager.blue,
    ),
    CategoryModel(
      category: "health",
      categoryImage: "assets/images/health.png",
      categoryName: "Health",
      categoryColor: ColorsManager.pink,
    ),
    CategoryModel(
      category: "business",
      categoryImage: "assets/images/bussines.png",
      categoryName: "Bussines",
      categoryColor: ColorsManager.lightBrown,
    ),
    CategoryModel(
      category: "technology",
      categoryImage: "assets/images/environment.png",
      categoryName: "Technology",
      categoryColor: Colors.lightBlue,
    ),
    CategoryModel(
      category: "science",
      categoryImage: "assets/images/science.png",
      categoryName: "Science",
      categoryColor: ColorsManager.lightYellow,
    ),
  ];

  CategoryModel? selectedCategory = null;
  List<ArticalModel> articalsData = [];

  void emitGetArticals(String categoryName, String sourceName) async {
    emit(const HomeState.loading());
    final response = await _homeRepo.getArticals(categoryName, sourceName);
    response.when(success: (data) {
      articalsData = data;
      emit(HomeState.success(articalsData));
    }, failure: (error) {
      selectedCategory = null;
      emit(HomeState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  List<SourcesTitle> sourcesTitle = [];

  void emitGetSourcesTitle() async {
    emit(const HomeState.loading());
    final response = await _homeRepo.getSoursesTitle();
    response.when(success: (data) {
      sourcesTitle = data;
      emit(HomeState.success(sourcesTitle));
    }, failure: (error) {
      emit(HomeState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  void emitCategory(CategoryModel? cat) {
    selectedCategory = cat;
    emit(HomeState.success(cat));
  }

  String sourceName = "";
  void emitSelectedSource(int sourceIntex) {
    sourceName = sourcesTitle[sourceIntex].id ?? "";
  }
}
