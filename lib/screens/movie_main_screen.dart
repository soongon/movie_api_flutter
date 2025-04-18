import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_flutter/screens/movie_detail_screen.dart';
import 'package:movie_api_flutter/services/movie_api_service.dart';
import 'package:movie_api_flutter/viewmodels/movie_state.dart';
import 'package:movie_api_flutter/widgets/movie_card.dart';
import 'package:movie_api_flutter/widgets/movie_menu_item.dart';

import '../providers/movie_provider.dart';
import '../widgets/movie_search_bar.dart';

class MovieMainScreen extends ConsumerWidget {
  const MovieMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🍿 영화 목록 카테고리
    final menuItems = ['현재 상영중', '인기', '최고평점', '개봉예정'];

    // 📦 상태 구독 및 ViewModel 접근
    final MovieState state = ref.watch(movieProvider);
    final vm = ref.read(movieProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('영화 앱'),
        leading: Icon(Icons.movie),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          // 🧭 상단 카테고리 메뉴
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              itemBuilder: (context, index) {
                return MovieMenuItem(
                  menuName: menuItems[index],
                  isSelected: state.selectedIndex == index,
                  onSelected: () {
                     vm.changeCategory(index);
                  },
                );
              },
              separatorBuilder: (_, __) => SizedBox(width: 16,),
              itemCount: menuItems.length,
            ),
          ),

          // 🔍 검색바 위젯
          MovieSearchBar(),

          if (state.isLoading)
            Expanded(child: Center(child: CircularProgressIndicator(),))
          else
            // 🎞️ 영화 목록 카드 뷰
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: state.movies[index],
                    onTap: () async {
                      final detail = await MovieApiService.fetchMovieDetail(state.movies[index].id);
                      // ✅ context가 여전히 유효한지 확인한 뒤 화면 전환
                      if (!context.mounted) return;
                      // 👉 상세 페이지로 이동
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailScreen(movie: detail,),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: 8,),
              ),
            ),
        ],
      ),
    );
  }
}
