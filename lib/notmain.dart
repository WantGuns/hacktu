import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';


void main() => runApp( MaterialApp(
    home: CheckEvents(),
  ));

class CheckEvents extends StatefulWidget {
  @override
  _CheckEventsState createState() => _CheckEventsState();
}

class _CheckEventsState extends State<CheckEvents> {

  String eventTitle;
  String id;

  void getEvents() async {
    String _title;
    Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
    Map<String, dynamic> events = jsonDecode(response.body);
    print(events['title']);
    setState(() => _title = events['id']);
    eventTitle = _title;
    //return _id;
  }

  
  //Widget build(BuildContext context) => ListEvents();
    //final List<String> items;
  //ListEvents({Key key, @required this.items}) : super(key: key);

  final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text("EVENTS"),
          titleSpacing: 20.0,
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network('https://images.unsplash.com/photo-1558980664-3a031cf67ea8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
              //title: Text('${items[index]}'),
              title: Text(eventTitle),
              trailing: RaisedButton(
                onPressed: () {},
                 child: Icon(Icons.more_vert),
              )
            );
          },
        ),
      ),
    );
  }
}

