part of 'get_bookmarked_bloc.dart';

class GetBookmarkedEvent extends Equatable {
  const GetBookmarkedEvent();

  @override
  List<Object> get props => [];
}

class GetBookmarkedByCategory extends GetBookmarkedEvent {
  final String category;
  const GetBookmarkedByCategory({required this.category});
}

class RemoveBookmarked extends GetBookmarkedEvent {
  final int bookMarkIndex;
  const RemoveBookmarked({required this.bookMarkIndex});
}
