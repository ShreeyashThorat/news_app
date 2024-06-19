part of 'get_news_bloc.dart';

class GetNewsEvent extends Equatable {
  const GetNewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsByCategory extends GetNewsEvent {
  final String? category;
  final String? newsTitle;
  final bool? addBookmark;
  const GetNewsByCategory({this.category, this.addBookmark = false, this.newsTitle});
}
