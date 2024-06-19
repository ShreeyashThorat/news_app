import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/local%20db/local_database.dart';

import '../../../data/repo/get_news_repo.dart';
import '../../../utils/exception/app_exception.dart';

part 'get_news_event.dart';
part 'get_news_state.dart';

class GetNewsBloc extends Bloc<GetNewsEvent, GetNewsState> {
  GetNewsBloc() : super(GetNewsInitial()) {
    on<GetNewsByCategory>((event, emit) async {
      if ((event.category != null || event.category != "") &&
          event.newsTitle == null &&
          event.addBookmark == false) {
        try {
          emit(LoadingState());
          final GetNewsRepo getNewsRepo = GetNewsRepo();
          final newsData = await getNewsRepo.getNews(event.category!);
          emit(GetNewsSuccessfully(news: newsData));
        } on AppException catch (e) {
          emit(ErrorState(exception: e));
          e.print;
        } catch (e) {
          log(e.toString());
          emit(ErrorState(exception: AppException()));
        }
      } else if (state is GetNewsSuccessfully &&
          event.category == null &&
          event.newsTitle != null) {
        GetNewsSuccessfully getNewsSuccessfully = state as GetNewsSuccessfully;
        final newsList = getNewsSuccessfully.news;
        if (event.addBookmark == false) {
          try {
            await LocalDatabase.deleteSingleNews(event.newsTitle!.trim());
            final news =
                newsList.firstWhere((item) => item.news.title!.trim() == event.newsTitle!.trim());
            final newsIndex =
                newsList.indexWhere((item) => item.news.title!.trim() == event.newsTitle!.trim());
            newsList.removeAt(newsIndex);
            final MyNewsMdel item =
                MyNewsMdel(news: news.news, isBookMarked: false);
            newsList.insert(newsIndex, item);
            return emit(getNewsSuccessfully.copyWith(newNews: newsList));
          } catch (err) {
            log(err.toString());
            rethrow;
          }
        } else if (event.addBookmark == true) {
          try {
            final news =
                newsList.firstWhere((item) => item.news.title!.trim() == event.newsTitle!.trim());
            await LocalDatabase.saveNews([news.news]);
            final newsIndex =
                newsList.indexWhere((item) => item.news.title!.trim() == event.newsTitle!.trim());
            newsList.removeAt(newsIndex);
            final MyNewsMdel item =
                MyNewsMdel(news: news.news, isBookMarked: true);
            newsList.insert(newsIndex, item);
            return emit(getNewsSuccessfully.copyWith(newNews: newsList));
          } catch (err) {
            log(err.toString());
            rethrow;
          }
        }
      }
    });
  }
}
