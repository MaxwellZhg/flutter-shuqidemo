import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_shuqi/model/article.dart';
import 'package:flutter_shuqi/model/chapter.dart';
import 'package:flutter_shuqi/app/app_scene.dart';
import 'package:flutter_shuqi/utility/screen.dart';
import 'package:flutter_shuqi/app/request.dart';
import 'package:flutter_shuqi/reader/reader_page_agent.dart';
import 'package:flutter_shuqi/reader/article_provider.dart';
import 'package:flutter_shuqi/reader/reader_utils.dart';
import 'package:flutter_shuqi/reader/reader_config.dart';
import 'package:flutter_shuqi/utility/toast.dart';
import 'package:flutter_shuqi/reader/reader_view.dart';
import 'package:flutter_shuqi/reader/reader_menu.dart';
enum PageJumpType { stay, firstPage, lastPage }

class ReaderScene extends StatefulWidget{
  final int articleId;

  ReaderScene({this.articleId});

  @override
  ReaderSceneState createState() {
    // TODO: implement createState
    return ReaderSceneState();
  }

}

class ReaderSceneState extends State<ReaderScene> with RouteAware{
  int pageIndex = 0;
  bool isMenuVisiable = false;
  PageController pageController = PageController(keepPage: false);
  bool isLoading = false;
  double topSafeHeight = 0;
  Article preArticle;
  Article currentArticle;
  Article nextArticle;

  List<Chapter> chapters =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(onScroll);
    setup();
  }

  @override
  void didPop() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    pageController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void setup() async{
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await Future.delayed(const Duration(milliseconds: 100),(){

    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    topSafeHeight = Screen.topSafeHeight;

    List<dynamic> chapterResponse = await Request.get(action: 'catalog');
    chapterResponse.forEach((data){
      chapters.add(Chapter.fromJson(data));
    });

    await resetContent(this.widget.articleId,PageJumpType.stay);

  }

  resetContent(int articleId,PageJumpType jumpType) async{
    currentArticle = await fetchArticle(articleId);

    if(currentArticle.preArticleId>0){
      preArticle = await fetchArticle(articleId);
    }else{
      preArticle = null;
    }

    if(currentArticle.nextArticleId>0){
      nextArticle = await fetchArticle(currentArticle.nextArticleId);
    }else{
      nextArticle = null;
    }
    if(jumpType == PageJumpType.firstPage){
      pageIndex = 0;
    }else if(jumpType == PageJumpType.lastPage){
      pageIndex = currentArticle.pageCount -1;
    }
    if(jumpType != PageJumpType.stay){
      pageController.jumpToPage((preArticle !=null ?preArticle.pageCount :0)+pageIndex);
    }
    setState(() {

    });
  }

  onScroll(){
    var page = pageController.offset/Screen.width;
    var nextArtilePage = currentArticle.pageCount+(preArticle!=null?preArticle.pageCount:0);
    if(page>=nextArtilePage){
      print('到达下个章节了');
      preArticle = currentArticle;
      currentArticle= nextArticle;
      nextArticle = null;
      pageIndex = 0;
      pageController.jumpToPage(preArticle.pageCount);
      fetchNextArticle(currentArticle.nextArticleId);
      setState(() {

      });
    }

    if(preArticle !=null && page<preArticle.pageCount -1){
      print('到达上个章节了');
      nextArticle = currentArticle;
      currentArticle = preArticle;
      preArticle = null;
      pageIndex = currentArticle.pageCount -1;
      pageController.jumpToPage(currentArticle.pageCount-1);
      fetchPreviousArticle(currentArticle.preArticleId);
      setState(() {

      });
    }
  }
  fetchPreviousArticle(int articleId) async {
    if (preArticle != null || isLoading || articleId == 0) {
      return;
    }
    isLoading = true;
    preArticle = await fetchArticle(articleId);
    pageController.jumpToPage(preArticle.pageCount + pageIndex);
    isLoading = false;
    setState(() {});
  }

  fetchNextArticle(int articleId) async {
    if (nextArticle != null || isLoading || articleId == 0) {
      return;
    }
    isLoading = true;
    nextArticle = await fetchArticle(articleId);
    isLoading = false;
    setState(() {});
  }

  Future<Article> fetchArticle(int articleId) async {
    var article = await ArticleProvider.fetchArticle(articleId);
    var contentHeight = Screen.height - topSafeHeight - ReaderUtils.topOffset - Screen.bottomSafeHeight - ReaderUtils.bottomOffset - 20;
    var contentWidth = Screen.width - 15 - 10;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(article.content, contentHeight, contentWidth, ReaderConfig.instance.fontSize);

    return article;
  }

  onTap(Offset position)async{
    double xRate = position.dx/Screen.width;
    if(xRate >0.33 &&xRate<0.66){
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top,SystemUiOverlay.bottom]);
      setState(() {
        isMenuVisiable = true;
      });
    }else if(xRate >=0.66){
      nextPage();
    }else{
      previousPage();
    }
  }

  onPageChanged(int index){
    var page = index-(preArticle !=null?preArticle.pageCount:0);
    if(page<currentArticle.pageCount&&page>=0){
      setState(() {
        pageIndex = page;
      });
    }
  }
  previousPage(){
    if(pageIndex ==0&&currentArticle.preArticleId==0){
      Toast.show('已经是第一页');
      return;
    }
    pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }
  nextPage() {
    if (pageIndex >= currentArticle.pageCount - 1 && currentArticle.nextArticleId == 0) {
      Toast.show('已经是最后一页了');
      return;
    }
    pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  Widget buildPage(BuildContext context , int index){
    var page = index - (preArticle !=null?preArticle.pageCount:0);
    var article;
    if(page >=this.currentArticle.pageCount){
      article = nextArticle;
      page = 0;
    }else if(page<0){
      article = preArticle;
      page = preArticle.pageCount-1;
    }else{
      article =this.currentArticle;
    }
    return GestureDetector(
      onTapUp: (TapUpDetails details){
        onTap(details.globalPosition);
      },
      child: ReaderView(article:article, page:page, topSafeHeight:topSafeHeight),
    );
  }

  buildPageView(){
    if(currentArticle == null){
      return Container();
    }

    int itemCount = (preArticle != null ? preArticle.pageCount : 0) + currentArticle.pageCount + (nextArticle != null ? nextArticle.pageCount : 0);
    return PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        itemCount: itemCount,
        itemBuilder: buildPage,
        onPageChanged: onPageChanged,
    );
  }

  buildMenu(){
     if(!isMenuVisiable){
       return Container();
     }
     return ReaderMenu(
       chapters: chapters,
       articleIndex: currentArticle.index,
       onTap: hideMenu,
       onPreviousArticle: (){
         resetContent(currentArticle.preArticleId, PageJumpType.firstPage);
       },
       onNextArticle: (){
         resetContent(currentArticle.preArticleId, PageJumpType.firstPage);
       },
       onToggleChapter: (Chapter chapter){
         resetContent(chapter.id, PageJumpType.firstPage);
       },
     );
  }
  hideMenu() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    setState(() {
      this.isMenuVisiable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
     if(currentArticle == null||chapters==null){
       return Scaffold();
     }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(left: 0, top: 0, right: 0, bottom: 0, child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
          buildPageView(),
          buildMenu(),
        ],
      ),
    );
  }

}