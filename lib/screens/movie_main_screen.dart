import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_api_flutter/screens/movie_detail_screen.dart';
import 'package:movie_api_flutter/services/movie_api_service.dart';
import 'package:movie_api_flutter/widgets/movie_card.dart';
import 'package:movie_api_flutter/widgets/movie_menu_item.dart';

import '../models/movie.dart';
import '../widgets/movie_search_bar.dart';

class MovieMainScreen extends HookWidget {
  const MovieMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🍿 영화 목록 카테고리
    final menuItems = ['현재 상영중', '인기', '최고평점', '개봉예정'];

    // ✅ 현재 선택된 메뉴 인덱스
    final selectedIndex = useState(0);

    // 🌐 선택된 카테고리에 따라 TMDB API 호출 (메모이즈 처리)
    final future = useMemoized(() {
      switch (selectedIndex.value) {
        case 0:
          return MovieApiService.fetchNowPlayingMovies();
        case 1:
          return MovieApiService.fetchPopularMovies();
        case 2:
          return MovieApiService.fetchTopRatedMovies();
        case 3:
          return MovieApiService.fetchUpcomingMovies();
        default:
          return MovieApiService.fetchNowPlayingMovies();
      }
    }, [selectedIndex.value]);

    // ⏳ Future 상태 추적 (로딩, 완료, 에러)
    final snapshot = useFuture(future);

    // ⏱️ 데이터 로딩 중이면 로딩 인디케이터 표시
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator(),);
    }

    // ⚠️ 에러 발생 또는 데이터 없음 처리
    if (snapshot.hasError || snapshot.data == null) {
      return Center(child: Text('에러 발생: ${snapshot.error}'),);
    }

    // 🎥 정상적으로 받아온 영화 리스트
    final List<Movie> movies = snapshot.data!;

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
                  isSelected: selectedIndex.value == index,
                  onSelected: () {
                    selectedIndex.value = index;
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 16,);
              },
              itemCount: menuItems.length,
            ),
          ),

          // 🔍 검색바 위젯
          MovieSearchBar(),

          // 🎞️ 영화 목록 카드 뷰
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: movies[index],
                  onTap: () async {
                    final detail = await MovieApiService.fetchMovieDetail(movies[index].id);
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
              separatorBuilder: (context, index) {
                return SizedBox(height: 8,);
              },
            ),
          ),
        ],
      ),
    );
  }
}
