import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';
import 'package:news_app/feature/home/ui/home_category_item.dart';

import '../../../core/theme/styles.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomAppBar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(30.sp),
                child: Column(
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
                              context.read<HomeCubit>().emitCategory(category);

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
              ),
            ),
          ],
        );
      },
    );
  }
}
