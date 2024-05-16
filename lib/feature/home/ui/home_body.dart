import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/helpers/extentions.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/core/theme/styles.dart';
import 'package:news_app/feature/home/data/models/category_model.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';
import 'package:news_app/feature/home/ui/news_screen.dart';
import 'package:news_app/feature/home/ui/home_category_item.dart';
import 'package:news_app/feature/home/ui/home_drawer.dart';

class HomeBody extends StatelessWidget {
  //businessentertainmentgeneralhealthsciencesportstechnology
  HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is HomeLoading ||
          current is HomeSuccess ||
          current is HomeError,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          drawer: HomeDrawer(
            onCategoryClick: () {
              context.read<HomeCubit>().emitSelectedSource(0);
              context.read<HomeCubit>().emitCategory(null);
              context.pop();
            },
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: ColorsManager.mainGreen,
            title: Text(
              context.read<HomeCubit>().selectedCategory == null
                  ? "News App"
                  : context.read<HomeCubit>().selectedCategory!.categoryName,
              style: TextStyles.font22WhiteRegular,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),
          body: context.read<HomeCubit>().selectedCategory == null
              ? Container(
                  padding: EdgeInsets.all(30.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pick your category ",
                        style: TextStyles.font24BlackBold,
                      ),
                      Text(
                        "of interest",
                        style: TextStyles.font24BlackBold,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                            childAspectRatio: 7 / 8,
                          ),
                          itemCount:
                              context.read<HomeCubit>().categoryList.length,
                          itemBuilder: ((context, index) {
                            return HomeCategoryItem(
                              onCategoryClick: (category) {
                                context
                                    .read<HomeCubit>()
                                    .emitCategory(category);

                                context.read<HomeCubit>().emitGetArticals(
                                    category.category,
                                    context.read<HomeCubit>().sourceName);
                                context.read<HomeCubit>().emitGetSourcesTitle();
                              },
                              categoryModel:
                                  context.read<HomeCubit>().categoryList[index],
                              categoryIndex: index,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              : NewsScreen(
                  categoryModel: context.read<HomeCubit>().selectedCategory!,
                ),
        );
      },
    );
  }
}
