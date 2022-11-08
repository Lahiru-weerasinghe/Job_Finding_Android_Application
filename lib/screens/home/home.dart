import 'package:flutter/material.dart';
import 'package:uee_assignment/constants/colors.dart';
import 'package:uee_assignment/screens/home/widgets/messages.dart';
import 'package:uee_assignment/screens/home/widgets/recent_contacts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body:Container(
        padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left:25),
              child: Text('Chat with\nyour friends',
              style: TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28),
              ),
            ),
            RecentContacts(),
            Messages()
          ],
        ),
      ),
    );
  }
}
