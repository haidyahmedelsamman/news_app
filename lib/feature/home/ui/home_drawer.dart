// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/helpers/extentions.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/styles.dart';

class HomeDrawer extends StatelessWidget {
  Function onCategoryClick;
   HomeDrawer({
    super.key,
    required this.onCategoryClick,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: ColorsManager.mainGreen,
            height: 90.h,
            width: double.infinity.sp,
            padding: EdgeInsets.only(bottom: 10.sp),
            alignment: Alignment.bottomCenter,
            child: Text(
              style: TextStyles.font22WhiteBold,
              textAlign: TextAlign.center,
              "News App",
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () => onCategoryClick(),
            child: Row(
              children: [
                SizedBox(
                  width: 10.h,
                ),
                Icon(
                  Icons.list,
                  size: 40.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "Categories",
                  style: TextStyles.font24BlackBold,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () => context.pushNamed(Routes.settingsScreen),
            child: Row(
              children: [
                SizedBox(
                  width: 10.h,
                ),
                Icon(
                  Icons.settings,
                  size: 40.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "Settings",
                  style: TextStyles.font24BlackBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
