import 'package:dio/dio.dart';
import 'package:newsapp/model/Newsmodel.dart';

class ApiNews {
  static const String _token = 'pub_97efcdace29341c087da5344a3278ad4';
  final Dio dio = Dio(
    BaseOptions(
    baseUrl: "https://newsdata.io/api/1",
      queryParameters:
      {
        'apikey':_token,
        'language':'en'
      }
    )
  );
  Future<NewsModel> getLatest({String? category}) async {
    final response = await dio.get(
      '/latest',
      queryParameters: {if (category != null) 'category': category},
    );
    return NewsModel.fromJson(response.data);
  }
  Future<NewsModel>searchNews(String query)async{
    final response=await dio.get("/latest",
    queryParameters: {
      'q':query
    });
    return NewsModel.fromJson(response.data);
  }

}