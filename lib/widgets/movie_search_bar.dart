import 'package:flutter/material.dart';

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
        ),
      ),
    );
  }
}
