// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/styles.dart';
import 'package:news_app/feature/home/data/models/sources_title_response.dart';

class SourceTabItem extends StatelessWidget {
  bool isSelected;
  SourcesTitle source;
  SourceTabItem({
    Key? key,
    required this.isSelected,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      decoration: isSelected
          ? BoxDecoration(
              color: ColorsManager.mainGreen,
              borderRadius: BorderRadius.circular(30),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: ColorsManager.mainGreen,
                width: 2.w,
              )),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
         source.name.toString(),
          style: isSelected
              ? TextStyles.font14WhiteRegular
              : TextStyles.font14GreenRegular,
        ),
      ),
    );
  }
}
