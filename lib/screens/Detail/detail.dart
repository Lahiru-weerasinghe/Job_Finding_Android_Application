import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uee_assignment/constants/colors.dart';
import 'package:uee_assignment/screens/Detail/widgets/contact_info.dart';
import 'package:uee_assignment/screens/Detail/widgets/detail_app_bar.dart';
import 'package:uee_assignment/screens/Detail/widgets/detail_message.dart';

import '../../models/message.dart';

class DetailPage extends StatelessWidget {
  final Message message;
  DetailPage(this.message);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Column(children: [DetailAppBar(),
      ContactInfo(message),
      Expanded(child: DetailMessages())]),
    );
  }
}