import 'package:flutter/material.dart';

import '../../components/bottom_navbar.dart';
import '../../components/side_navbar.dart';
import '../../constants.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class MyCompanyScreen extends StatefulWidget {
  const MyCompanyScreen({Key key}) : super(key: key);

  @override
  State<MyCompanyScreen> createState() => _MyCompanyScreenState();
}

class _MyCompanyScreenState extends State<MyCompanyScreen> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  final List<Item> _data = generateItems(8);

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
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>(
            (Item item) {
              return ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: Color(0xFF434343),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    tileColor: Color(0xFF434343),
                    title: Text(item.headerValue),
                  );
                },
                body: ListTile(
                  tileColor: Color(0xFF434343),
                  title: Text(item.expandedValue),
                  subtitle: const Text(
                      'To delete this panel, tap the trash can icon'),
                  trailing: const Icon(Icons.delete),
                  onTap: () {
                    setState(
                      () {
                        _data.removeWhere(
                            (Item currentItem) => item == currentItem);
                      },
                    );
                  },
                ),
                isExpanded: item.isExpanded,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
