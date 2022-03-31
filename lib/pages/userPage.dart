import 'package:flutter/material.dart';

import 'package:papelcart/pages/signin.dart';
import 'package:papelcart/pages/signup.dart';
import 'package:mysql_client/mysql_client.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key, required this.pool, required this.email})
      : super(key: key);

  final MySQLConnectionPool pool;
  String email;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: My Subscriptions',
      style: optionStyle,
    ),
    Text(
      'Index 1: Publications',
      style: optionStyle,
    ),
    Text(
      'Index 2: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var subs = widget.pool.execute(
        "SELECT * FROM subscription,user where user.Email_Id = :email_id AND subscription.User_Id=user.Id",
        {
          "email_id": widget.email,
        });
    List<String> l = ["Hi Lawde"];
    subs.then((value) {
      for (var s in value.rows) {
        l.add(s.assoc()["Address"]!);
      }
    });
    return Scaffold(
      body: Container(
        child: Column(
          children: [for (var i in l) Text(i.toString())],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'My Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Publications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300,
      height: 200,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.red,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album, size: 60),
              title: Text('Sonu Nigam', style: TextStyle(fontSize: 30.0)),
              subtitle: Text('Best of Sonu Nigam Music.',
                  style: TextStyle(fontSize: 18.0)),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: const Text('Play'),
                  onPressed: () {/* ... */},
                ),
                RaisedButton(
                  child: const Text('Pause'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
