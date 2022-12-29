import "package:flutter/material.dart";
import 'package:linkup/components/add_post_feed.dart';
import 'package:linkup/components/bottom_navbar.dart';
import 'package:linkup/components/post_card.dart';
import 'package:linkup/components/side_navbar.dart';
import 'package:linkup/constants.dart';

class PostFeedScreen extends StatefulWidget {
  const PostFeedScreen({Key key}) : super(key: key);

  @override
  _PostFeedScreenState createState() => _PostFeedScreenState();
}

class _PostFeedScreenState extends State<PostFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post Feed",
          style: TextStyle(
            fontFamily: "SF-Pro",
          ),
        ),
        backgroundColor: colorDarkMidGround,
        elevation: 0.0,
      ),
      backgroundColor: colorDarkBackground,
      drawer: const SideNavbar(),
      bottomNavigationBar: const BottomNavbar(),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              AddPostFeed(),
              PostCard(
                profileImageURL:
                    "https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg",
                fullName: "Yohani Ariyarathne",
                description:
                    "A job description not only describes the position’s responsibilities, it sets the foundation for recruiting, developing and retaining talent and also sets the stage for optimum work performance by clarifying responsibilities, expected results, and evaluation of performance. It is also an important component to maintaining an equitable compensation system and ensuring legal compliance. The document should be revisited and updated in line with the annual performance evaluation cycle.",
                position: "Associate Software Engineer",
                postImage:
                    "https://templates.mediamodifier.com/5e9709395e1d70189ea21cd1/job-posting-linkedin-post-template.jpg",
              ),
              PostCard(
                profileImageURL:
                    "https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg",
                fullName: "Yohani Ariyarathne",
                description:
                    "A job description not only describes the position’s responsibilities, it sets the foundation for recruiting, developing and retaining talent and also sets the stage for optimum work performance by clarifying responsibilities, expected results, and evaluation of performance. It is also an important component to maintaining an equitable compensation system and ensuring legal compliance. The document should be revisited and updated in line with the annual performance evaluation cycle.",
                position: "Associate Software Engineer",
                postImage:
                    "https://templates.mediamodifier.com/5e9709395e1d70189ea21cd1/job-posting-linkedin-post-template.jpg",
              ),
              PostCard(
                profileImageURL:
                    "https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg",
                fullName: "Yohani Ariyarathne",
                description:
                    "A job description not only describes the position’s responsibilities, it sets the foundation for recruiting, developing and retaining talent and also sets the stage for optimum work performance by clarifying responsibilities, expected results, and evaluation of performance. It is also an important component to maintaining an equitable compensation system and ensuring legal compliance. The document should be revisited and updated in line with the annual performance evaluation cycle.",
                position: "Associate Software Engineer",
                postImage:
                    "https://templates.mediamodifier.com/5e9709395e1d70189ea21cd1/job-posting-linkedin-post-template.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
