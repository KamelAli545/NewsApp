import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/core/ApiNews.dart';
import 'package:newsapp/model/News.dart';
import 'package:newsapp/model/Newsmodel.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  final ApiNews apiNews=ApiNews();
  String? _category;

  Future<void> loadNews([String? category]) async {
    _category = category;
    emit(NewsLoading());
    try {
      final result = await apiNews.getLatest(category: category);
      emit(NewsSuccess(result.results ?? []));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> searchNews(String query) async {
    final text = query.trim();
    if (text.isEmpty) {
      await loadNews(_category);
      return;
    }
    emit(NewsLoading());
    try {
      final result = await apiNews.searchNews(text);
      emit(NewsSuccess(result.results ?? []));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
