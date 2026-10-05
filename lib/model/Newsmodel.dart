import 'News.dart';

class NewsModel {
  NewsModel({
      this.status, 
      this.totalResults, 
      this.results, 
      this.nextPage,});

  NewsModel.fromJson(dynamic json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(News.fromJson(v));
      });
    }
    nextPage = json['nextPage'];
  }
  String? status;
  int? totalResults;
  List<News>? results;
  String? nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['totalResults'] = totalResults;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['nextPage'] = nextPage;
    return map;
  }

}