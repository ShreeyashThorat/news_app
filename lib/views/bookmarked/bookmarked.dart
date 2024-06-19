import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/repo/get_news_repo.dart';
import 'package:news_app/logic/get_bookmarked/bloc/get_bookmarked_bloc.dart';
import 'package:news_app/utils/constant_data.dart';
import 'package:news_app/widgets/news_container.dart';

class Bookmarked extends StatefulWidget {
  const Bookmarked({super.key});

  @override
  State<Bookmarked> createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked> {
  final GetBookmarkedBloc getBookmarkedBloc = GetBookmarkedBloc();
  int selectedCategory = 0;
  bool messageShowed = false;

  @override
  void initState() {
    getBookmarkedBloc.add(GetBookmarkedByCategory(
        category: ConstantData.categoriesList[selectedCategory].toLowerCase()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 5),
          child: Row(
            children: [
              ...List.generate(ConstantData.categoriesList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                    getBookmarkedBloc.add(GetBookmarkedByCategory(
                        category:
                            ConstantData.categoriesList[index].toLowerCase()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 21),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: selectedCategory == index
                            ? Colors.blueGrey
                            : Colors.white),
                    child: Text(
                      ConstantData.categoriesList[index],
                      style: TextStyle(
                        fontSize: 18,
                        color: selectedCategory == index
                            ? Colors.white
                            : const Color.fromRGBO(128, 129, 145, 1),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: BlocConsumer<GetBookmarkedBloc, GetBookmarkedState>(
                bloc: getBookmarkedBloc,
                listener: (context, state) {
                  if (state is GetBookmarkedSuccessfully &&
                      state.news.isNotEmpty &&
                      messageShowed == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Swipe left to remove bookmarked news")));
                    setState(() {
                      messageShowed = true;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is BookmarkedLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BookmarkedError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else if (state is GetBookmarkedSuccessfully &&
                      state.news.isEmpty) {
                    return const Center(
                      child: Text("Oops...There are no saved news"),
                    );
                  } else if (state is GetBookmarkedSuccessfully &&
                      state.news.isNotEmpty) {
                    return ListView.builder(
                        itemCount: state.news.length,
                        itemBuilder: (context, index) {
                          final data = state.news[index];
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              getBookmarkedBloc
                                  .add(RemoveBookmarked(bookMarkIndex: index));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    final news = MyNewsMdel(
                                        news: data, isBookMarked: true);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                singleNewsScreen(news: news)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: 7),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: CachedNetworkImage(
                                            cacheKey: data.imageUrl,
                                            alignment: Alignment.center,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                            fadeInDuration: const Duration(
                                                milliseconds: 200),
                                            fadeInCurve: Curves.easeInOut,
                                            imageUrl: data.imageUrl != null ||
                                                    data.imageUrl != ""
                                                ? data.imageUrl!
                                                : ConstantData.newsDefalutImage,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            progressIndicatorBuilder:
                                                (context, url, progress) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                data.title!.trim(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                data.author!.trim(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black45),
                                              ),
                                              Text(
                                                "${data.date!.trim()} ${data.time!.trim()}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                state.news.length - 1 != index
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.03),
                                        child: Divider(
                                          height: 1,
                                          color: Colors.grey.shade200,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          );
                        });
                  }
                  return Container();
                }))
      ],
    ));
  }

  Widget singleNewsScreen({required MyNewsMdel news}) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: NewsContainer(news: news, fromBookmark: true),
            )));
  }
}
