import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var event;

void main() => runApp( MaterialApp(
    home: CheckEvents(),
  ));

class CheckEvents extends StatefulWidget {
  @override
  _CheckEventsState createState() => _CheckEventsState();
}

class _CheckEventsState extends State<CheckEvents> {

  @override
  // FIREBASE WORK STARTS HERE
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _message = '';
  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  void getMessage(){
   _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      setState(() => _message = message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      setState(() => _message = message["notification"]["title"]);
    });
  } 

  // FIREBASE ENDS HERE  

  void getEvents() async {
    Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
    event = jsonDecode(response.body);
    print(event['id']);
  }

  
_launchURL() async {
  const url = 'https://i.redd.it/x3dqd57hdyx31.jpg';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  void initState() {
    super.initState();
    getEvents();
    getMessage();
  }


  @override
  Widget build(BuildContext context) => Home(); 
}

class Home extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final title = 'Long List';
    print(event['title']);
   // print(eventTitle);
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "EVENTS",
            ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount:  5,
          itemBuilder: (context, index) {
            return Card (
              child: ListTile(
              //onTap: _launchURL(),
              leading: Icon(Icons.bookmark),
              //title: Text('${items[index]}'),
              title: Text(event['title']),
              subtitle: Column (
                children: <Widget>[
                    Text(event['title']),
                    Text(event['title']),
                    Text(event['title']),
                    /*Text(event[index]['event_time']),
                    Text(event[index]['event_date']),
                    Text(event[index]['event_des']), */
                ],
              ),
              trailing: FlatButton(
                onPressed: () async {
                  Response responsRSVP = await get('http://171.61.222.17:8082/post/${event[index]['id']}/rsvp/');
                },
                child: Text("RSVP")
                )
              ),
            );
          },
        ),
      ),
      theme: ThemeData (
        accentColor: Colors.indigoAccent,
        primarySwatch: Colors.orange
      ),
      debugShowCheckedModeBanner: true,
    );
  }
}