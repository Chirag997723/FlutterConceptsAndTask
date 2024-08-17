import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/mvc_ex/api_controllar.dart';
import 'package:flutter_practice_app/old_file/mvc_ex/api_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class NewsApi extends StatefulWidget {
  @override
  State createState() => _NewsApiState();
}

class _NewsApiState extends StateMVC<NewsApi> {
  _NewsApiState() : super(ApiControllar()) {
    con = controller as ApiControllar;
  }
  late ApiControllar con;

  @override
  void initState() {
    con.getNewsList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Text(con.newsModel[index]['description']??'NA');
      },
      itemCount: con.newsModel.length,),
    );
  }
}