import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_flutter/screens/movie_main_screen.dart';

void main() {
  runApp(
    // 🛡️ Riverpod 상태 관리를 전역에서 사용할 수 있도록 ProviderScope로 감쌈
    const ProviderScope(
      child: MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '영화 앱(Movie App)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MovieMainScreen(),
    );
  }
}
