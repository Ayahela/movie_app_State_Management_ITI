import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/cubit/movie_cubit.dart';
import 'features/view/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff191923),
        brightness: Brightness.dark,

      ),
      home: BlocProvider(
        create: (context) => MovieCubit(),
        child: const HomeScreen(),
      ),
    );
  }
}