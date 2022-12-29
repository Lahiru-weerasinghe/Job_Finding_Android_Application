import 'package:flutter/material.dart';

import '../../components/bottom_navbar.dart';
import '../../components/side_navbar.dart';
import '../../constants.dart';

class MyconpaniesScreen extends StatefulWidget {
  const MyconpaniesScreen({Key key}) : super(key: key);

  @override
  State<MyconpaniesScreen> createState() => _MyconpaniesScreenState();
}

class _MyconpaniesScreenState extends State<MyconpaniesScreen> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LinkUp",
          style: TextStyle(
            fontFamily: "SF-Pro",
          ),
        ),
        backgroundColor: colorDarkMidGround,
        elevation: 0.0,
      ),
      backgroundColor: colorDarkBackground,
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
            key: Key(item),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                items.removeAt(index);
              });

              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$item dismissed')));
            },
            // Show a red background as the item is swiped away.
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "DELETE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: fontFamilySFPro),
                  )
                ],
              ),
            ),
            child: ListTile(
              title: Text(
                item,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
