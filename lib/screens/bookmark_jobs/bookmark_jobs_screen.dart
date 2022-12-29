import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/side_navbar.dart';
import '../../constants.dart';
import 'bookmark_job_body_card.dart';

class BookMarkedJobsScreen extends StatefulWidget {
  const BookMarkedJobsScreen({Key key}) : super(key: key);

  @override
  State<BookMarkedJobsScreen> createState() => _BookMarkedJobsScreenState();
}

class _BookMarkedJobsScreenState extends State<BookMarkedJobsScreen> {
  bool _isExpanded = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: colorDarkBackground,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: orientation == Orientation.landscape
                ? size.width * 0.75
                : size.width,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Column(
              children: [
                for (var i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      collapsedBackgroundColor: colorDarkMidGround,
                      backgroundColor: colorDarkMidGround,
                      leading: const Icon(
                        FontAwesomeIcons.bookmark,
                        color: colorTextPrimary,
                        size: 30,
                      ),
                      title: const Text(
                        "Associate Software Engineer",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: fontFamilySFPro,
                          color: colorTextPrimary,
                        ),
                      ),
                      subtitle: const Text(
                        "Google In.",
                        style: TextStyle(
                          fontFamily: fontFamilySFPro,
                          color: colorTextPrimary,
                        ),
                      ),
                      trailing: Icon(
                        _index == i && _isExpanded
                            ? Icons.arrow_circle_up
                            : Icons.arrow_circle_down,
                        color: colorTextPrimary,
                        size: 30,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _index = i;
                          _isExpanded = expanded;
                        });
                      },
                      children: const <Widget>[
                        BookmarkedJobBodyCard(
                          companyLogo:
                              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png",
                          companyName: "Google In.",
                          description:
                              "A job description not only describes the position’s responsibilities, it sets the foundation for recruiting, developing and retaining talent and also sets the stage for optimum work performance by clarifying responsibilities, expected results, and evaluation of performance. It is also an important component to maintaining an equitable compensation system and ensuring legal compliance. The document should be revisited and updated in line with the annual performance evaluation cycle.",
                          position: "Associate Software Engineer",
                          postImage:
                              "https://templates.mediamodifier.com/5e9709395e1d70189ea21cd1/job-posting-linkedin-post-template.jpg",
                          qualifications: "Test",
                          salary: "45000",
                          type: "Full Time",
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
