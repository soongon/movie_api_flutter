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
  /// 카테고리를 변경할 때 searchQuery를 초기화하지 않으면 검색 상태가 고정되므로,
  /// 이 코드 추가도 필요합니다 👇
  void changeCategory(int index) {
    state = state.copyWith(
      selectedIndex: index,
      searchQuery: '',
      isSearching: false,
      searchResults: [],
      isLoading: true,
    );
    loadMovies();
  }

  /// 🔍 검색어가 변경될 때마다 TMDB API 호출
  Future<void> updateSearchQuery(String query) async {
    state = state.copyWith(searchQuery: query, isSearching: true, errorMessage: null,);

    if (query.isEmpty) {
      state = state.copyWith(searchResults: [], isSearching: false);
      return;
    }

    try {
      final results = await MovieApiService.searchMovies(query);
      state = state.copyWith(searchResults: results, isSearching: false);
    } catch (e) {
      state = state.copyWith(
        searchResults: [],
        isSearching: false,
        errorMessage: '검색 중 오류가 발생했습니다 ❗',
      );
    }
  }

  /// 🎥 선택된 카테고리에 따른 영화 목록 요청
  Future<void> loadMovies() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

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
      // 🛑 에러 발생 시: 영화 목록 비우고 에러 메시지 저장
      state = state.copyWith(
        movies: [],
        errorMessage: '영화를 불러오는 중 오류가 발생했습니다 😥',
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
