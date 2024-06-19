import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/data/repo/get_news_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constant_data.dart';

class NewsContainer extends StatefulWidget {
  final MyNewsMdel news;
  final Function()? bookMark;
  final bool? fromBookmark;
  const NewsContainer(
      {super.key,
      required this.news,
      this.bookMark,
      this.fromBookmark = false});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = widget.news.news;
    return Container(
      height: size.height,
      width: size.width,
      margin: EdgeInsets.only(
          left: size.width * 0.05, right: size.width * 0.05, bottom: 20),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(widget.fromBookmark == false ? 15 : 0),
          boxShadow: widget.fromBookmark == false
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, 4),
                      blurRadius: 2,
                      blurStyle: BlurStyle.outer)
                ]
              : []),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: widget.fromBookmark == false
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))
                    : BorderRadius.circular(0),
                child: CachedNetworkImage(
                  cacheKey: data.imageUrl,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  width: size.width,
                  height: 250,
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeInCurve: Curves.easeInOut,
                  imageUrl: data.imageUrl != null || data.imageUrl != ""
                      ? data.imageUrl!
                      : ConstantData.newsDefalutImage,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, progress) {
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              widget.fromBookmark == false
                  ? Positioned(
                      top: 5,
                      right: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.white.withOpacity(0.5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                shareButton(),
                                IconButton(
                                  onPressed: widget.bookMark ?? () {},
                                  icon: SvgPicture.asset(
                                    width: 24,
                                    height: 24,
                                    widget.news.isBookMarked
                                        ? ConstantImages.bookmarkSolid
                                        : ConstantImages.bookmarkOutline,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                top: 5,
                left: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              Uri uri = Uri.parse(data.readMoreUrl!);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(
                                  uri,
                                  mode: LaunchMode.inAppBrowserView,
                                );
                              } else {
                                throw 'Could not launch $uri';
                              }
                            },
                            icon: SvgPicture.asset(
                              width: 24,
                              height: 24,
                              ConstantImages.link,
                            ),
                          ),
                          widget.fromBookmark == true
                              ? shareButton()
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02, vertical: 5),
              children: [
                Text(
                  data.title!.trim(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  data.content!.trim(),
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
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
    );
  }

  Widget shareButton() {
    return IconButton(
      onPressed: () async {},
      icon: const Icon(
        Icons.share_rounded,
        size: 20,
        color: Colors.black,
      ),
    );
  }
}
