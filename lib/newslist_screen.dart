import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:technewsfeeder/webview_screen.dart';
import 'package:technewsfeeder/fetch_newsdata.dart';
import 'package:technewsfeeder/favorite_screen.dart';
import 'package:technewsfeeder/footer.dart';

class NewsListScreen extends StatefulWidget {
  // "static const" is always as this value.
  static const String id = 'newslist_screen';

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {

  int _selectedIndex;
  List<bool> _isFavorite = List.generate(20, (i)=>false);

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
          future: fetchNewsData(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
      bottomNavigationBar: Footer(),
      );
  }

  Widget listViewWidget(List<NewsDataList> article) {
    return Container(
      child: ListView.builder(
          itemCount: 20,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (BuildContext context, int position) {
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
                  trailing: _favoriteIconButton(context, position),
                onTap: () {
                  print(article[position].url);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewScreen(url: article[position].url)),
                  );
                },
              ),
            );
          }),
    );
  }

  IconButton _favoriteIconButton( BuildContext context, int position, {IconData iconData}){
    print('_isFavorite on favoButton function is $_isFavorite');
    print('position is $position');
    return(
      IconButton(
        icon: Icon(
          _isFavorite[position] == true ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite[position] == true ? Colors.red : null,
        ),
        onPressed: (){
          setState(() {
            if(_isFavorite[position] == false) {
              _isFavorite[position] = true;
            } else {
              _isFavorite[position] = false;
            }
          });
        },
      )
    );
  }

  }





