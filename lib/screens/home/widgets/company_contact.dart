import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConatctCard extends StatelessWidget {
  const ConatctCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text("Contact Card"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      height:30
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/apple.jpg'),
                  ),
                  Text(
                    'Apple',
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.email, size: 32, color: Colors.black),
                      title: Text('apple@gmail.com',
                          style: TextStyle(fontSize: 21, color: Colors.black)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.phone, size: 32, color: Colors.black),
                      title: Text('0994568976',
                          style: TextStyle(fontSize: 21, color: Colors.black)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}