import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/home/data/models/category_model.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/colors.dart';
import '../../data/models/artical_model.dart';
import '../../data/models/sources_title_response.dart';
import '../../data/repos/home_repo.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    articalsData = [];
    emit(const HomeState.articalsLoading());
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

  int selectedIndex = 0;

  List<ArticalModel> searchedList = [];
  bool isSearching = false;
  TextEditingController controller = TextEditingController();

  void emitStartSearching() {
    emit(const HomeState.search());
    isSearching = true;
  }

  void emitStopSearching() {
    emit(const HomeState.stopSearch());
    isSearching = false;
    searchedList = [];
    controller.clear();
  }

  void emitSearching(String searchedCharacter) {
    searchedList = [];
    emit(const HomeState.articalsSearchedLoading());

    try {
      isSearching = true;
      searchedList = articalsData
          .where((artical) =>
              artical.title!.toLowerCase().startsWith(searchedCharacter))
          .toList();
      emit(const HomeState.search());
    } catch (message) {
      emit(HomeState.articalsSearchedError(error: message.toString()));
    }
  }

  String formatArticalDate(String inputDateString) {
    final articalTime = DateTime.parse(inputDateString);
    final now = DateTime.now();
    final difference = now.difference(articalTime);
    final formatedDate = timeago.format(now.subtract(difference));
    return formatedDate;
  }

  Future<void> launchingUrl(String inputUrl) async {
    final Uri url = Uri.parse(inputUrl);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
