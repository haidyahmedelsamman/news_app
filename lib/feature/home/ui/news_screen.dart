import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/feature/home/data/models/category_model.dart';
import 'package:news_app/feature/home/logic/cubit/home_cubit.dart';
import 'package:news_app/feature/home/logic/cubit/home_state.dart';
import 'package:news_app/feature/home/ui/artical_item.dart';
import 'package:news_app/feature/home/ui/source_tab_item.dart';

class NewsScreen extends StatefulWidget {
  CategoryModel categoryModel;
  NewsScreen({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeError) {
          return Center(
            child: Text(state.error),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            // SourcesTabsList(
            //   sources: context.read<HomeCubit>().sourcesTitle,
            //   category: categoryModel.category,
            // ),
            DefaultTabController(
              length: context.read<HomeCubit>().sourcesTitle.length,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.transparent,
                    onTap: (index) {
                      setState(() {
                         selectedIndex = index;
                        context.read<HomeCubit>().emitSelectedSource(selectedIndex);

                        context.read<HomeCubit>().emitGetArticals(
                           widget.categoryModel.category, context.read<HomeCubit>().sourceName);
                    
                      });
                       
                    },
                    isScrollable: true,
                    tabs: context.read<HomeCubit>().sourcesTitle
                        .map((item) => SourceTabItem(
                              isSelected:
                                 context.read<HomeCubit>().sourcesTitle.indexOf(item) == selectedIndex,
                              source: item,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ArticalItem(
                        articalModel: context.read<HomeCubit>()
                                .articalsData[index]);
                  },
                  itemCount: context.read<HomeCubit>().articalsData.length),
            ),
          ],
        );
},
    );
  }
}
