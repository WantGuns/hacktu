import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() => runApp( MaterialApp(
    home: CheckEvents(),
  ));

class CheckEvents extends StatefulWidget {
  @override
  _CheckEventsState createState() => _CheckEventsState();
}

class _CheckEventsState extends State<CheckEvents> {

  /*
  // FIREBASE WORK STARTS HERE
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _message = '';
  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

 // var mess = "";
  //var gunwant = "moron";
  void getMessage(){
   _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      //print('on message $message');
      //setState(() => _message = '$gunwant');
      setState(() => _message = message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      //print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      //print('on launch $gunwant');
      setState(() => _message = message["notification"]["title"]);
      //mess = message as String;
    });
  }

  // FIREBASE ENDS HERE  */



  var eventTitle;
  var id;
  var eventTitleList = new List(3);

  void getEvents() async {
    //Response res = await get('http://172.16.93.238:8000/json');
    Response response = await get('http://171.61.222.17:8082/media/test.json');


    //Map<String, dynamic> events = jsonDecode(response.body);
    eventTitle = jsonDecode(response.body);//['event_name'];
    //print(eventTitle[0]['event_name']);
    //print(events['title']);
    //setState(() => _title = events['title']);
    //eventTitle = events['title'];
    //setState(() => _id = events['id']);
    //id = events['id'];
    //return _id;
    
  }

  
_launchURL() async {
  const url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  //Widget build(BuildContext context) => ListEvents();
    //final List<String> items;
  //ListEvents({Key key, @required this.items}) : super(key: key);

  //final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  void initState() {
    super.initState();
    getEvents();
    //getMessage();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';
   // print(eventTitle);
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVENTS"),

          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount:  5,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
              leading: Image.network('https://images.unsplash.com/photo-1558980664-3a031cf67ea8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
              //title: Text('${items[index]}'),
              title: Text(eventTitle[index]['event_name']),
              //subtitle: Text('$id'),
              trailing: IconButton(
                onPressed: () {
                  _launchURL();
                },
                icon: Icon(Icons.more_vert),
                )
              ),
            );
          },
        ),
      ),
    );
  }
}

