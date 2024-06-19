import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/data/local%20db/local_database.dart';
import 'package:news_app/data/model/news%20model/news_model.dart';

import '../../core/api.dart';
import '../../utils/exception/app_exception.dart';

class GetNewsRepo {
  Future<List<MyNewsMdel>> getNews(String category) async {
    try {
      final Api api = Api();
      Response response = await api.sendRequest.get("/news?category=$category");
      if (response.statusCode == 200 && response.data['success']) {
        final newsData = response.data['data'];
        List<MyNewsMdel> newsList = [];
        final savedNewsList = await LocalDatabase.getNewsData();
        final titles = savedNewsList.map((item) => item.title!.trim()).toSet();
        for (var item in newsData) {
          item['category'] = response.data['category'];
          final NewsModel news = NewsModel.fromJson(item);
          bool isBookMarked = titles.contains(news.title!.trim());
          newsList.add(
              MyNewsMdel(news: news, isBookMarked: isBookMarked));
        }
        return newsList;
      } else {
        AppExceptionHandler.throwException(null, response.statusCode);
      }
    } on DioException catch (e) {
      AppExceptionHandler.throwException(e);
    } catch (err) {
      log(err.toString());
      AppExceptionHandler.throwException(err);
    }
    throw AppException();
  }
}

class MyNewsMdel {
  final NewsModel news;
  final bool isBookMarked;
  MyNewsMdel({required this.news, required this.isBookMarked});
}
