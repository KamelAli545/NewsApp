import 'package:bloc/bloc.dart';
import 'package:newsapp/core/ApiNews.dart';
import 'package:newsapp/model/News.dart';
import 'package:newsapp/model/Newsmodel.dart';
import 'package:newsapp/widgets/newsTab.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final ApiNews apiNews = ApiNews();
  NewsCategory _currentCategory = NewsCategory.general;
  int _requestId = 0;


  Future<void> loadCategory(NewsCategory category) async {
    _currentCategory = category;
    final id = ++_requestId;
    emit(NewsLoading());
    try {
      final result = await _fetch(category);
      if (id != _requestId) return;
      emit(NewsSuccess(result.results ?? []));
    } catch (e) {
      if (id != _requestId) return;
      emit(NewsError(e.toString()));
    }
  }

  Future<NewsModel> _fetch(NewsCategory category) {
    final apiCategory = category == NewsCategory.general ? 'top' : category.name;
    return apiNews.getLatest(category: apiCategory);

  }

  Future<void> searchNews(String query) async {
    final text = query.trim();
    if (text.isEmpty) {
      await loadCategory(_currentCategory);
      return;
    }
    final id = ++_requestId;
    emit(NewsLoading());
    try {
      final result = await apiNews.searchNews(text);
      if (id != _requestId) return;
      emit(NewsSuccess(result.results ?? []));
    } catch (e) {
      if (id != _requestId) return;
      emit(NewsError(e.toString()));
    }
  }
}