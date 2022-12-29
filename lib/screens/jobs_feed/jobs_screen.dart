import "package:flutter/material.dart";
import 'package:linkup/components/add_job_feed.dart';
import 'package:linkup/components/job_card.dart';
import 'package:linkup/models/job_model.dart';
import 'package:linkup/providers/job_provider.dart';
import 'package:linkup/screens/application_form/application_form_screen.dart';
import 'package:provider/provider.dart';
import 'package:linkup/constants.dart';

class JobsFeedScreen extends StatefulWidget {
  const JobsFeedScreen({Key key}) : super(key: key);

  @override
  JobsFeedScreenState createState() => JobsFeedScreenState();
}

class JobsFeedScreenState extends State<JobsFeedScreen> {
  Future<List<Job>> jobs;
  RouteSettings settings;

  @override
  void initState() {
    super.initState();
    jobs = Provider.of<JobProvider>(context, listen: false).getJobs();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorDarkBackground,
      body: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: FutureBuilder<List<Job>>(
                future: jobs,
                builder: (context, snapshot) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: RefreshIndicator(
                      child: _listView(snapshot),
                      onRefresh: _pullRefresh,
                    ),
                  );
                },
              ),
            ),
            const AddJobFeed(),
          ],
        ),
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: ((context, index) {
          return JobCard(
            companyLogo: snapshot.data[index].companyLogo,
            companyName: snapshot.data[index].companyName,
            description: snapshot.data[index].description,
            position: snapshot.data[index].position,
            jobImage: snapshot.data[index].jobImage,
            salary: snapshot.data[index].salary,
            isPublic: true,
            onClick: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ApplicationFormScreen(
                    jobId: snapshot.data[index].id,
                  ),
                  settings: settings,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          SlideTransition(
                    child: child,
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                  ),
                ),
              );
            },
          );
        }),
      );
    } else if (snapshot.hasError) {
      return const Text(
        'Error with load posts',
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

  Future<void> _pullRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      jobs = Provider.of<JobProvider>(context, listen: false).getJobs();
    });
  }
}
