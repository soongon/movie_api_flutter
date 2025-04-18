import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_api_flutter/screens/movie_detail_screen.dart';
import 'package:movie_api_flutter/viewmodels/movie_state.dart';
import 'package:movie_api_flutter/widgets/movie_card.dart';
import 'package:movie_api_flutter/widgets/movie_menu_item.dart';
import 'package:movie_api_flutter/widgets/shimmer_card.dart';

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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: 6,
                itemBuilder: (context, index) => const ShimmerCard(),
              ),
            )
          else
            // 🎞️ 영화 목록 카드 뷰
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: state.movies[index],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movieId: state.movies[index].id),
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
