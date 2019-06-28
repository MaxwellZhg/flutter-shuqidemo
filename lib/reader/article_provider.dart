import 'package:flutter_shuqi/model/article.dart';
import 'package:flutter_shuqi/app/request.dart';
class ArticleProvider{
  static Future<Article> fetchArticle(int articleId) async{
    var response = await Request.get(action: 'article_$articleId');
    var article = Article.fromJson(response);
    return article;
  }
}