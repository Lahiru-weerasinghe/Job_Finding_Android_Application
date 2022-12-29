import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/models/application_model.dart';
import 'package:linkup/providers/application_provider.dart';
import 'package:linkup/screens/applications/application_tile.dart';
import 'package:linkup/screens/applications/edit_application.dart';
import 'package:provider/provider.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key key}) : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  Future<List<Application>> _applications;
  ApplicationProvider _applicationProvider;
  RouteSettings settings;
  bool _isExpanded;
  int _index;

  @override
  void initState() {
    super.initState();
    _applicationProvider = context.read<ApplicationProvider>();
    _applications = _applicationProvider.getUserApplications(context);
    _isExpanded = false;
    _index = 0;
  }

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
            height: size.height,
            padding: const EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.topCenter,
                child: FutureBuilder<List<Application>>(
                  future: _applications,
                  builder: (context, snapshot) {
                    return RefreshIndicator(
                      child: _listView(snapshot),
                      onRefresh: _pullRefresh,
                    );
                  },
                ),
              ),
            ),
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
              key: Key(snapshot.data[index].id),
              closeOnScroll: true,
              endActionPane: ActionPane(
                dismissible: DismissiblePane(
                  onDismissed: () {
                    _applicationProvider.deleteApplication(
                      context,
                      snapshot.data[index].id,
                    );
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
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => EditApplicationScreen(
                            applicantName: snapshot.data[index].applicantName,
                            contactNumber: snapshot.data[index].contactNumber,
                            github: snapshot.data[index].github,
                            linkedIn: snapshot.data[index].linkedIn,
                            languages: snapshot.data[index].languages,
                            nic: snapshot.data[index].nic,
                            skills: snapshot.data[index].skills,
                            university: snapshot.data[index].university,
                            applicationId: snapshot.data[index].id,
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
                    backgroundColor: colorTextPrimary,
                    foregroundColor: colorDarkBackground,
                    spacing: 5,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ],
              ),
              child: ApplicationTile(
                index: index,
                isExpanded: _isExpanded,
                iterateIndex: index,
                title: snapshot.data[index].companyName,
                subTitle: snapshot.data[index].position,
                application: Application(
                  applicantName: snapshot.data[index].applicantName,
                  companyName: snapshot.data[index].companyName,
                  contactNumber: snapshot.data[index].contactNumber,
                  github: snapshot.data[index].github,
                  linkedIn: snapshot.data[index].linkedIn,
                  languages: snapshot.data[index].languages,
                  nic: snapshot.data[index].nic,
                  position: snapshot.data[index].position,
                  skills: snapshot.data[index].skills,
                  status: snapshot.data[index].status,
                  university: snapshot.data[index].university,
                  id: snapshot.data[index].id,
                ),
              ),
            );
          }),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Image.asset('assets/images/application.png'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'You have not apply to any job yet',
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
      _applications = _applicationProvider.getUserApplications(context);
    });
  }
}
