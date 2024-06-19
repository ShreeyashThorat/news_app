import 'package:hive/hive.dart';

import '../model/news model/news_model.dart';

class LocalDatabase {
  static Future<void> saveNews(List<NewsModel> news) async {
    final newsBox = await Hive.openBox<NewsModel>('news');
    await newsBox.addAll(news);
    await newsBox.close();
  }

  static Future<List<NewsModel>> getNewsData() async {
    final newsBox = await Hive.openBox<NewsModel>('news');
    List<NewsModel> newsData = newsBox.values.toList();
    await newsBox.close();
    return newsData;
  }

  static Future<void> deleteNewsData() async {
    final newsBox = await Hive.openBox<NewsModel>('news');
    await newsBox.clear();
    await newsBox.close();
  }

  static Future<void> deleteSingleNews(String title) async {
    final newsBox = await Hive.openBox<NewsModel>('news');
    List<NewsModel> newsList = newsBox.values.toList();
    newsList.removeWhere((news) => news.title!.trim() == title.trim());
    await Hive.deleteBoxFromDisk('news');
    await LocalDatabase.saveNews(newsList);
  }
}
