// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/data/model/news%20model/news_model.dart';
import 'package:news_app/logic/get%20news/bloc/get_news_bloc.dart';
import 'package:news_app/logic/get_bookmarked/bloc/get_bookmarked_bloc.dart';
import 'package:news_app/views/auth/login_screen.dart';

import 'logic/bottom_nav/cubit/bottom_nav_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsModelAdapter());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => GetNewsBloc()),
        BlocProvider(create: (context) => GetBookmarkedBloc()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(0.8, 0.9);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
              child: child!);
        },
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'FiraSans',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true),
        home: const LoginScreen(),
      ),
    );
  }
}
