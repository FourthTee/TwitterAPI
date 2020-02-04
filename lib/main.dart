import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MaterialApp(
  home: new HomePage(),


));

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  final String url = "/1.1/search/tweets.json?q=from%3ANasa%20OR%20%23nasa";
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accpet": "application/json"}

    );

    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['statuses'];
    });

    return "Success";

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Twitter Trends"),
      ),
      body:  new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: new Center(
              child:  new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
