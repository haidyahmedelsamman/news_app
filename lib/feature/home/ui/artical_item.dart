// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/artical_model.dart';

class ArticalItem extends StatelessWidget {
 

  ArticalModel articalModel;
  ArticalItem({
    Key? key,
    required this.articalModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.sp,horizontal: 10.sp),
      child: Column(
        children: [
          Image.network(articalModel.urlToImage ?? ""),
          Text(articalModel.author ?? ""),
          Text(articalModel.title ?? ""),
          Text(articalModel.publishedAt ?? "")
        ],
      ),
    );
  }
}
