part of 'get_bookmarked_bloc.dart';

class GetBookmarkedState extends Equatable {
  const GetBookmarkedState();

  @override
  List<Object> get props => [];
}

class GetBookmarkedInitial extends GetBookmarkedState {}

class BookmarkedLoading extends GetBookmarkedState {}

class BookmarkedError extends GetBookmarkedState {
  final String error;
  const BookmarkedError({required this.error});
  @override
  List<Object> get props => [error];
}

class GetBookmarkedSuccessfully extends GetBookmarkedState {
  final List<NewsModel> news;
  const GetBookmarkedSuccessfully({required this.news});
  GetBookmarkedSuccessfully copyWith({List<NewsModel>? newNews}) {
    return GetBookmarkedSuccessfully(news: newNews ?? news);
  }

  @override
  List<Object> get props => [news];
}
