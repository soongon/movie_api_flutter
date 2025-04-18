import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../services/movie_api_service.dart';
import 'movie_state.dart';

/// 🎬 영화 상태 및 로직을 관리하는 뷰모델 (Riverpod StateNotifier)
class MovieViewModel extends StateNotifier<MovieState> {
  MovieViewModel() : super(MovieState.initial()) {
    loadMovies(); // 초기 데이터 로드
  }

  /// 🔁 카테고리 변경 시 상태 갱신 및 데이터 다시 로드
  void changeCategory(int index) {
    state = state.copyWith(selectedIndex: index);
    loadMovies();
  }

  /// 🎥 선택된 카테고리에 따른 영화 목록 요청
  Future<void> loadMovies() async {
    state = state.copyWith(isLoading: true);

    try {
      List<Movie> movies;
      switch (state.selectedIndex) {
        case 0:
          movies = await MovieApiService.fetchNowPlayingMovies();
          break;
        case 1:
          movies = await MovieApiService.fetchPopularMovies();
          break;
        case 2:
          movies = await MovieApiService.fetchTopRatedMovies();
          break;
        case 3:
          movies = await MovieApiService.fetchUpcomingMovies();
          break;
        default:
          movies = [];
      }

      state = state.copyWith(movies: movies);
    } catch (e) {
      // 에러 핸들링 추가 가능
      state = state.copyWith(movies: []);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
