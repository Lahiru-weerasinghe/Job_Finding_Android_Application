import "package:flutter/material.dart";
import 'package:linkup/components/application_card.dart';
import 'package:linkup/components/bottom_navbar.dart';
import 'package:linkup/components/job_card.dart';
import 'package:linkup/components/side_navbar.dart';
import 'package:linkup/constants.dart';

class SingleJobScreen extends StatefulWidget {
  const SingleJobScreen({Key key}) : super(key: key);

  @override
  _SingleJobScreenState createState() => _SingleJobScreenState();
}

class _SingleJobScreenState extends State<SingleJobScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Applications",
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
            children: [
              Column(
                children: const [
                  JobCard(
                    companyLogo:
                        "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png",
                    companyName: "Google In.",
                    description:
                        "A job description not only describes the position’s responsibilities, it sets the foundation for recruiting, developing and retaining talent and also sets the stage for optimum work performance by clarifying responsibilities, expected results, and evaluation of performance. It is also an important component to maintaining an equitable compensation system and ensuring legal compliance. The document should be revisited and updated in line with the annual performance evaluation cycle.",
                    position: "Associate Software Engineer",
                    jobImage:
                        "https://templates.mediamodifier.com/5e9709395e1d70189ea21cd1/job-posting-linkedin-post-template.jpg",
                    salary: "45000",
                  ),
                ],
              ),
              Column(
                children: const [
                  ApplicationCard(
                    profileImageURL:
                        "https://monteluke.com.au/wp-content/gallery/linkedin-profile-pictures/34217-MLS-Fabian-Ekker-003flin.jpg",
                    applicantName: "Senura Jayadeva",
                    position: "Associate Software Engineer",
                  ),
                  ApplicationCard(
                    profileImageURL:
                        "https://monteluke.com.au/wp-content/gallery/linkedin-profile-pictures/34217-MLS-Fabian-Ekker-003flin.jpg",
                    applicantName: "Senura Jayadeva",
                    position: "Associate Software Engineer",
                  ),
                  ApplicationCard(
                    profileImageURL:
                        "https://monteluke.com.au/wp-content/gallery/linkedin-profile-pictures/34217-MLS-Fabian-Ekker-003flin.jpg",
                    applicantName: "Senura Jayadeva",
                    position: "Associate Software Engineer",
                  ),
                  ApplicationCard(
                    profileImageURL:
                        "https://monteluke.com.au/wp-content/gallery/linkedin-profile-pictures/34217-MLS-Fabian-Ekker-003flin.jpg",
                    applicantName: "Senura Jayadeva",
                    position: "Associate Software Engineer",
                  ),
                  ApplicationCard(
                    profileImageURL:
                        "https://monteluke.com.au/wp-content/gallery/linkedin-profile-pictures/34217-MLS-Fabian-Ekker-003flin.jpg",
                    applicantName: "Senura Jayadeva",
                    position: "Associate Software Engineer",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
