// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/helpers/extentions.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/theme/styles.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';

import '../data/models/artical_model.dart';

class ArticalItem extends StatelessWidget {
  final ArticalModel articalModel;
  const ArticalItem({
    super.key,
    required this.articalModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.pushNamed(Routes.articalDetailsScreen,
              arguments: articalModel),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    articalModel.urlToImage ?? "",
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(articalModel.author ?? ""),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  articalModel.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyles.font16BlackMedium,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  context.read<HomeCubit>().formatArticalDate(articalModel.publishedAt ?? ""),
                  textAlign: TextAlign.end,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
