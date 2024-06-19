part of 'get_news_bloc.dart';

class GetNewsState extends Equatable {
  const GetNewsState();

  @override
  List<Object> get props => [];
}

class GetNewsInitial extends GetNewsState {}

class LoadingState extends GetNewsState {}

class ErrorState extends GetNewsState {
  final AppException exception;
  const ErrorState({required this.exception});
  @override
  List<Object> get props => [exception];
}

class GetNewsSuccessfully extends GetNewsState {
  final List<MyNewsMdel> news;
  const GetNewsSuccessfully({required this.news});
  GetNewsSuccessfully copyWith({List<MyNewsMdel>? newNews}) {
    return GetNewsSuccessfully(news: newNews ?? news);
  }

  @override
  List<Object> get props => [news];
}

