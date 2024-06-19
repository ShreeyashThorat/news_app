import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(NavbarItem.home, 0));
  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const BottomNavState(NavbarItem.home, 0));
        break;
      case NavbarItem.bookmarked:
        emit(const BottomNavState(NavbarItem.bookmarked, 1));
        break;
    }
  }
}


class BottomNavState extends Equatable {
  final NavbarItem navbarItem;
  final int index;
  const BottomNavState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}



enum NavbarItem {
  home,
  bookmarked,
}
