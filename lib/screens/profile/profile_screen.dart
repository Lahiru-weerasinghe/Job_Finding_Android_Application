import "package:flutter/material.dart";
import 'package:linkup/components/education_card.dart';
import 'package:linkup/components/experience_card.dart';
import 'package:linkup/components/skills_card.dart';
import 'package:linkup/components/user_image_upload.dart';
import 'package:linkup/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkup/models/experience_model.dart';
import 'package:linkup/providers/experience_provider.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:provider/provider.dart';

Future<List<Experience>> _experiences;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider userProvider;
  ExperienceProvider _expProvider;

  @override
  void initState() {
    super.initState();
    _expProvider = context.read<ExperienceProvider>();
    _experiences = _expProvider.getExperience(context);
    userProvider = context.read<UserProvider>();
    userProvider.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDarkBackground,
      body: Align(
        alignment: Alignment.topCenter,
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _ProfileHeaderCard(),
                _ExperienceSection(),
                _EducationSection(),
                _SkillsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _experiences = Provider.of<ExperienceProvider>(context, listen: false)
          .getExperience(context);

      userProvider.getProfile(context);
    });
  }
}

class _ProfileHeaderCard extends StatefulWidget {
  const _ProfileHeaderCard({Key key}) : super(key: key);

  @override
  _ProfileHeaderCardState createState() => _ProfileHeaderCardState();
}

class _ProfileHeaderCardState extends State<_ProfileHeaderCard> {
  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width:
          orientation == Orientation.landscape ? size.width * 0.75 : size.width,
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        color: colorDarkMidGround,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: UserImageUpload(
                imageURL: userProvider.user.profileImageURL != ''
                    ? userProvider.user.profileImageURL
                    : defaultProfileImage,
                onFileChanged: ((imageURL) {
                  setState(() {
                    userProvider.user.profileImageURL = imageURL;
                    userProvider.updateProfileImage(context);
                  });
                }),
              ),
            ),
            Text(
              userProvider.user.firstName + " " + userProvider.user.lastName,
              style: const TextStyle(
                fontFamily: fontFamilySFPro,
                fontSize: 24,
                color: colorTextPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              userProvider.user.position,
              style: const TextStyle(
                fontFamily: fontFamilySFPro,
                fontSize: 16,
                color: colorTextPrimary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  FontAwesomeIcons.facebook,
                  color: colorTextPrimary,
                  size: 30,
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  FontAwesomeIcons.linkedin,
                  color: colorTextPrimary,
                  size: 30,
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  FontAwesomeIcons.instagram,
                  color: colorTextPrimary,
                  size: 30,
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  FontAwesomeIcons.github,
                  color: colorTextPrimary,
                  size: 30,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 5),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 16,
                      color: colorPrimaryLight,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceSection extends StatefulWidget {
  @override
  _ExperienceSectionState createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<_ExperienceSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width:
          orientation == Orientation.landscape ? size.width * 0.75 : size.width,
      padding: const EdgeInsets.only(top: 0),
      child: Card(
        color: colorDarkMidGround,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Experience",
                    style: TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 18,
                      color: colorTextPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add-experience");
                    },
                    icon: const Icon(
                      Icons.add,
                      color: colorTextPrimary,
                    ),
                  )
                ],
              ),
              FutureBuilder<List<Experience>>(
                future: _experiences,
                builder: (context, snapshot) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: _listView(snapshot),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return Column(
        children: [
          for (var i = 0; i < snapshot.data.length; i++)
            ExperienceCard(
              companyName: snapshot.data[i].companyName,
              position: snapshot.data[i].position,
              description: snapshot.data[i].description,
            )
        ],
      );
    } else if (snapshot.hasError) {
      return const Text(
        'Error with fetch experiences',
        style: TextStyle(
          fontFamily: fontFamilySFPro,
          fontSize: 16,
          color: colorTextPrimary,
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: colorTextPrimary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _EducationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width:
          orientation == Orientation.landscape ? size.width * 0.75 : size.width,
      padding: const EdgeInsets.only(top: 0),
      child: Card(
        color: colorDarkMidGround,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Education",
                    style: TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 18,
                      color: colorTextPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add-education");
                    },
                    icon: const Icon(
                      Icons.add,
                      color: colorTextPrimary,
                    ),
                  )
                ],
              ),
              for (var i = 0; i < 2; i++)
                const EducationCard(
                  schoolName: "SLIIT",
                  course: "B.Sc (Hons) Software Engineering",
                  period: "2019 - 2023",
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width:
          orientation == Orientation.landscape ? size.width * 0.75 : size.width,
      padding: const EdgeInsets.only(top: 0),
      child: Card(
        color: colorDarkMidGround,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Skills",
                    style: TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 18,
                      color: colorTextPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add-skill");
                    },
                    icon: const Icon(
                      Icons.add,
                      color: colorTextPrimary,
                    ),
                  )
                ],
              ),
              for (var i = 0; i < 2; i++)
                const SkillCard(
                  skill: "Java",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
