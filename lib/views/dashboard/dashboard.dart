// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/views/bookmarked/bookmarked.dart';
import 'package:news_app/views/home/home_screen.dart';

import '../../logic/bottom_nav/cubit/bottom_nav_cubit.dart';
import '../../utils/constant_data.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        if (state.navbarItem == NavbarItem.home) {
          return const HomeScreen();
        } else if (state.navbarItem == NavbarItem.bookmarked) {
          return const Bookmarked();
        }
        return Container();
      },
    ), bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme:
                const IconThemeData(size: 23, color: Colors.white),
            unselectedIconTheme:
                IconThemeData(size: 20, color: Colors.grey.shade500),
            elevation: 3,
            backgroundColor: Colors.white,
            currentIndex: state.index,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  width: 24,
                  height: 24,
                  ConstantImages.homeOutline,
                ),
                activeIcon: SvgPicture.asset(
                  width: 26,
                  height: 26,
                  color: ColorTheme.primaryColor,
                  ConstantImages.homeSolid,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  width: 24,
                  height: 24,
                  ConstantImages.bookmarkOutline,
                ),
                activeIcon: SvgPicture.asset(
                  width: 26,
                  height: 26,
                  color: ColorTheme.primaryColor,
                  ConstantImages.bookmarkSolid,
                ),
                label: 'Bookmark',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.bookmarked);
              }
            },
          ),
        );
      },
    ));
  }
}
