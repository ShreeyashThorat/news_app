import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/data/local%20db/local_database.dart';
import 'package:news_app/data/model/news%20model/news_model.dart';

part 'get_bookmarked_event.dart';
part 'get_bookmarked_state.dart';

class GetBookmarkedBloc extends Bloc<GetBookmarkedEvent, GetBookmarkedState> {
  GetBookmarkedBloc() : super(GetBookmarkedInitial()) {
    List<NewsModel> newsList = [];
    on<GetBookmarkedByCategory>((event, emit) async {
      emit(BookmarkedLoading());
      try {
        newsList =
            newsList.isEmpty ? await LocalDatabase.getNewsData() : newsList;
        if (event.category == "all") {
          emit(GetBookmarkedSuccessfully(news: newsList));
        } else {
          final filteredList = newsList
              .where((news) => news.category == event.category)
              .toList();
          emit(GetBookmarkedSuccessfully(news: filteredList));
        }
      } catch (err) {
        emit(const BookmarkedError(error: "Failed to get saved news"));
      }
    });

    on<RemoveBookmarked>((event, emit) async {
      if (state is GetBookmarkedSuccessfully) {
        GetBookmarkedSuccessfully getBookmarkedSuccessfully =
            state as GetBookmarkedSuccessfully;
        final newsList = getBookmarkedSuccessfully.news;
        final news = newsList.elementAt(event.bookMarkIndex);
        try {
          await LocalDatabase.deleteSingleNews(news.title!.trim());
          newsList.removeAt(event.bookMarkIndex);
          return emit(getBookmarkedSuccessfully.copyWith(newNews: newsList));
        } catch (err) {
          log(err.toString());
          rethrow;
        }
      }
    });
  }
}
