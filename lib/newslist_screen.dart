import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NewsListScreen extends StatefulWidget {
  // "static const" is always as this value.
  static const String id = 'newslist_screen';

  String get newsType => null;

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {

  Future<NewsDataList> dataList;

  // Animation controller init method
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tech News App'),
        ),
      body: FutureBuilder(
          future: fetchNewsData(widget.newsType),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
      );
  }

  Widget listViewWidget(List<NewsDataList> article) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  '${article[position].title}',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: article[position].urlToImage == null
                        ? Image(
                      image: AssetImage(''),
                    )
                        : Image.network('${article[position].urlToImage}'),
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                onTap: () {},
              ),
            );
          }),
    );
  }


}

class NewsDataList {

  final String title;
  final String url;
  final String urlToImage;

  NewsDataList({this.title, this.url, this.urlToImage});

  factory NewsDataList.fromJson(Map<String, dynamic> json) {
    return NewsDataList(
      title: json['title'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
    );
  }
}


Future<List<NewsDataList>> fetchNewsData(String newsType) async {

  List<NewsDataList> list;
  String url = "http://newsapi.org/v2/top-headlines?country=jp&category=technology&apiKey=f289d460a5f94d4087d54cd187becceb";
  var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

  print(res.body);

  if(res.statusCode == 200){
    var data = json.decode(res.body);
    var rest = data["articles"] as List;
    print(rest);
    list = rest.map<NewsDataList>((json) => NewsDataList.fromJson(json)).toList();
    return list;
  } else {
    throw Exception('Failed to load album');
  }
}


