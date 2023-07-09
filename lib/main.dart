import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/pages/admin_pages/home_page/home_page.dart';
import 'package:university_project/pages/home_page.dart';

import 'core/utils/app_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(
    BlocProvider<AppCubit>(
      create: (context) => AppCubit()..getAllEmployees(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'laboratory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 350,
        splash: Image.asset(AppImages.appLogoPath),
        nextScreen: const AdminHomePage(),
      ),
    );
  }
}
