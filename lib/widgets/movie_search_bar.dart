// 📦 필요한 패키지: flutter_hooks, flutter_riverpod
// HookConsumerWidget 사용을 위해 두 패키지가 모두 필요합니다.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_api_flutter/providers/movie_provider.dart';
import 'dart:async';

// 🧩 HookConsumerWidget: useRef 훅과 Provider 접근을 동시에 사용할 수 있는 위젯
class MovieSearchBar extends HookConsumerWidget {
  const MovieSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debounce = useRef<Timer?>(null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: SizedBox(
        height: 48,
        child: TextField(
          decoration: InputDecoration(
            hintText: '영화 제목을 입력하세요',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
          ),
          onChanged: (query) {
            // 🛑 기존 타이머가 있으면 취소
            // ⏳ 500ms 후 검색어를 ViewModel에 전달하여 디바운싱 적용
            debounce.value?.cancel();
            debounce.value = Timer(const Duration(milliseconds: 500), () {
              ref.read(movieProvider.notifier).updateSearchQuery(query);
            });
          },
        ),
      ),
    );
  }
}
