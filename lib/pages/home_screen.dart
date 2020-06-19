import 'package:flutter/material.dart';
import 'package:nytimes/helpers/responsive_helper.dart';
import 'package:nytimes/models/article_model.dart';
import 'package:nytimes/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> _articles = [];

  @override
  void initState() {
    // TODO: implement initState

    _fetchArticles();
  }

  _fetchArticles() async {
    List<Article> articles =
        await APIService().fetchArticlesBySection('technology');
    setState(() {
      _articles = articles;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 80,
          ),
          Center(
            child: Text(
              "The New York Times \n Top Tech Articles",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          _articles.length > 0
              ? _buildArticlesGrid(mediaQuery)
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                )
        ],
      ),
    );
  }

  _buildArticlesGrid(MediaQueryData mediaQuery) {
    List<GridTile> tiles = [];
    _articles.forEach((element) {
      tiles.add(_buildArticleTile(element, mediaQuery));
    });
    return Padding(
      padding: responsivePadding(mediaQuery),
      child: GridView.count(
        crossAxisCount: responsiveNumberOfTiles(mediaQuery),
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: tiles,
      ),
    );
  }

  _buildArticleTile(Article element, MediaQueryData mediaQuery) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          _launchUrl(element.url);
        },
        child: Column(
          children: [
            Container(
              height: responsiveImageHeight(mediaQuery),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(element.imageUrl),
                      fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: responsiveTitleHeight(mediaQuery),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 1),
                        blurRadius: 6)
                  ]),
              child: Text(
                element.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
