import '../models/movie.dart';

/// 🎬 화면 상태를 담는 상태 모델 클래스
class MovieState {
  /// 📌 선택된 메뉴 인덱스 (예: 0 = 현재 상영, 1 = 인기 등)
  final int selectedIndex;

  /// 🎞️ 현재 화면에 표시할 영화 목록
  final List<Movie> movies;

  /// ⏳ 로딩 중 여부 (API 호출 중 상태)
  final bool isLoading;

  /// 🔍 검색 쿼리
  final String searchQuery;

  /// 🔍 검색 중 여부
  final bool isSearching;

  /// 🎞️ 검색 결과 목록
  final List<Movie> searchResults;


  MovieState({
    required this.selectedIndex,
    required this.movies,
    required this.isLoading,
    required this.searchQuery,
    required this.isSearching,
    required this.searchResults,
  });

  /// 🆕 초기 상태 생성자 (앱 시작 시 기본 상태)
  factory MovieState.initial() {
    return MovieState(
      selectedIndex: 0,
      movies: [],
      isLoading: false,
      searchQuery: '',
      isSearching: false,
      searchResults: [],
    );
  }

  /// 🔁 기존 상태에서 일부 값만 변경할 수 있는 copyWith 메서드
  MovieState copyWith({
    int? selectedIndex,
    List<Movie>? movies,
    bool? isLoading,
    String? searchQuery,
    bool? isSearching,
    List<Movie>? searchResults,
  }) {
    return MovieState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
