import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/helpers/extentions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/styles.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';
import 'package:news_app/feature/home/ui/home_categories_list.dart';
import 'package:news_app/feature/home/ui/news_screen.dart';
import 'package:news_app/feature/home/ui/home_drawer.dart';
import 'package:news_app/feature/home/ui/search_text_field.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is HomeLoading ||
          current is HomeSuccess ||
          current is HomeSearch ||
          current is HomeStopSearch ||
          current is HomeError,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          drawer: HomeDrawer(
            onCategoryClick: () {
              context.read<HomeCubit>().emitStopSearching();
              context.read<HomeCubit>().isSearching = false;
              if (context.read<HomeCubit>().sourceName != "") {
                context.read<HomeCubit>().emitSelectedSource(0);
              }
              context.read<HomeCubit>().selectedIndex = 0;
              context.read<HomeCubit>().emitCategory(null);
              context.pop();
            },
          ),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          appBar: AppBar(
            toolbarHeight: 70.h,
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: ColorsManager.mainGreen,
            actions: context.read<HomeCubit>().selectedCategory != null
                ? [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 6),
                      child: GestureDetector(
                        onTap: () {
                          context.read<HomeCubit>().emitStartSearching();
                        },
                        child: Image.asset(
                          "assets/images/icon_search.png",
                          height: 28.h,
                          width: 28.w,
                        ),
                      ),
                    )
                  ]
                : [],
            title: context.read<HomeCubit>().isSearching == true
                ? Container(
                    height: 40.h,
                    padding: EdgeInsets.only(right: 12.sp),
                    child: SearchTextField(),
                  )
                : Text(
                    context.read<HomeCubit>().selectedCategory == null
                        ? "News App"
                        : context
                            .read<HomeCubit>()
                            .selectedCategory!
                            .categoryName,
                    style: TextStyles.font22WhiteRegular,
                  ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
          ),
          body: context.read<HomeCubit>().selectedCategory == null
              ? const HomeCategoriesList()
              : NewsScreen(
                  categoryModel: context.read<HomeCubit>().selectedCategory!,
                ),
        );
      },
    );
  }
}
