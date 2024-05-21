// import 'dart:ffi';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/theme/styles.dart';
import 'package:news_app/feature/home/data/models/category_model.dart';

// ignore: must_be_immutable
class HomeCategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  void Function(CategoryModel) onCategoryClick;
  int categoryIndex;
  HomeCategoryItem({
    super.key,
    required this.categoryModel,
    required this.onCategoryClick,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCategoryClick(categoryModel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: categoryModel.categoryColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomRight: Radius.circular(categoryIndex % 2 == 0 ? 0 : 25),
            bottomLeft: Radius.circular(categoryIndex % 2 == 0 ? 25 : 0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              categoryModel.categoryImage,
              height: 90.h,
            ),
            Text(
              categoryModel.categoryName,
              style: TextStyles.font22WhiteRegular,
            )
          ],
        ),
      ),
    );
  }
}
