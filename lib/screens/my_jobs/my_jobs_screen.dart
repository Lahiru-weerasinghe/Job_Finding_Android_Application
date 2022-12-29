import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:linkup/components/job_card.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/models/job_model.dart';
import 'package:linkup/providers/job_provider.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:linkup/screens/my_jobs/edit_my_job.dart';
import 'package:provider/provider.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({Key key}) : super(key: key);

  @override
  _MyJobsScreenState createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  Future<List<Job>> userJobs;
  JobProvider _jobProvider;
  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _jobProvider = context.read<JobProvider>();

    userJobs = _userProvider.getUserJobs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDarkBackground,
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 10),
          child: FutureBuilder<List<Job>>(
            future: userJobs,
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
      ),
    );
  }

  Widget _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data.length > 0) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: ((context, index) {
            return Slidable(
              closeOnScroll: true,
              key: Key(snapshot.data[index].id),
              child: JobCard(
                companyLogo: snapshot.data[index].companyLogo,
                companyName: snapshot.data[index].companyName,
                description: snapshot.data[index].description,
                position: snapshot.data[index].position,
                jobImage: snapshot.data[index].jobImage,
                salary: snapshot.data[index].salary,
                isPublic: false,
              ),
              endActionPane: ActionPane(
                dismissible: DismissiblePane(
                  onDismissed: () {
                    _jobProvider.deleteJob(context, snapshot.data[index].id);
                    _userProvider.getProfile(context);
                  },
                ),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      print("Delete");
                    },
                    backgroundColor: colorError,
                    foregroundColor: colorTextPrimary,
                    spacing: 5,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
                motion: const DrawerMotion(),
              ),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditJob(
                            id: snapshot.data[index].id,
                            companyLogo: snapshot.data[index].companyLogo,
                            jobImage: snapshot.data[index].jobImage,
                            description: snapshot.data[index].description,
                            position: snapshot.data[index].position,
                            salary: snapshot.data[index].salary,
                            companyName: snapshot.data[index].companyName,
                          ),
                        ),
                      );
                    },
                    backgroundColor: colorTextPrimary,
                    foregroundColor: colorDarkBackground,
                    spacing: 5,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
            );
          }),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Image.asset(
                'assets/images/job.png',
                fit: BoxFit.cover,
                width: 90,
                height: 90,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'You have not publish any jobs to LinkUp',
                style: TextStyle(
                  fontFamily: fontFamilySFPro,
                  fontSize: 18,
                  color: colorTextPrimary,
                ),
              ),
            ],
          ),
        );
      }
    } else if (snapshot.hasError) {
      return Column(
        children: [
          Image.asset(
            'assets/images/server.png',
            fit: BoxFit.cover,
            width: 110,
            height: 110,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'We have some problem with fetching data',
            style: TextStyle(
              fontFamily: fontFamilySFPro,
              fontSize: 18,
              color: colorTextPrimary,
            ),
          ),
        ],
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
      userJobs = Provider.of<UserProvider>(context, listen: false)
          .getUserJobs(context);
    });
  }
}
