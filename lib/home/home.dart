import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:job_finder_app/screens/home/widgets/home_app_bar.dart';
import 'package:job_finder_app/screens/home/widgets/job_list.dart';
import 'package:job_finder_app/screens/home/widgets/search_card.dart';
import 'package:job_finder_app/screens/home/widgets/tag_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              SearchCard(),
              TagList(),
              JobList(),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).primaryColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Case',
                icon: Icon(
                  Icons.cases_outlined,
                  size: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Text(''),
              ),
              BottomNavigationBarItem(
                label: 'Chat',
                icon: Icon(
                  Icons.chat_outlined,
                  size: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Person',
                icon: Icon(
                  Icons.person_outline,
                  size: 20,
                ),
              ),
            ]),
      ),
    );
  }
}
