import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/views/home/widgets/categories_bottom_sheet.dart';
import 'package:news_app/widgets/news_container.dart';

import '../../logic/get news/bloc/get_news_bloc.dart';
import '../../utils/constant_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetNewsBloc getNewsBloc = GetNewsBloc();
  String selectedCategory = ConstantData.categoriesList[1].toLowerCase();
  @override
  void initState() {
    getNewsBloc.add(GetNewsByCategory(category: selectedCategory));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    exit(0);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context1) => CategoriesBottomSheet(
                              applyCategory: (value) {
                                getNewsBloc
                                    .add(GetNewsByCategory(category: value));
                                setState(() {
                                  selectedCategory = value;
                                });
                                Navigator.pop(context);
                              },
                              selectedCategory: selectedCategory,
                            ));
                  },
                  icon: SvgPicture.asset(
                    width: 24,
                    height: 24,
                    ConstantImages.categories,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: BlocBuilder<GetNewsBloc, GetNewsState>(
            bloc: getNewsBloc,
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorState) {
                return Center(
                  child:
                      Text(state.exception.message ?? "Something went wrong!"),
                );
              } else if (state is GetNewsSuccessfully && state.news.isEmpty) {
                return const Center(
                  child: Text("Oops...There are no latest news"),
                );
              } else if (state is GetNewsSuccessfully &&
                  state.news.isNotEmpty) {
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final data = state.news[index];
                      return NewsContainer(
                        news: data,
                        bookMark: () {
                          getNewsBloc.add(GetNewsByCategory(
                              newsTitle: data.news.title,
                              addBookmark: !data.isBookMarked));
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {});
                          });
                        },
                      );
                    });
              }
              return Container();
            },
          )),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
