import "package:flutter/material.dart";
import 'package:linkup/providers/application_provider.dart';
import 'package:linkup/providers/experience_provider.dart';
import 'package:linkup/providers/job_provider.dart';
import 'package:linkup/providers/post_provider.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:linkup/routes/page_routes.dart';
import 'package:linkup/screens/home/home.dart';
import 'package:linkup/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => JobProvider()),
          ChangeNotifierProvider(create: (_) => ApplicationProvider()),
          ChangeNotifierProvider(create: (_) => ExperienceProvider()),
        ],
        child: const LinkUpApp(),
      ),
    );

class LinkUpApp extends StatelessWidget {
  const LinkUpApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(
        duration: 3,
        navigationPage: HomeScreen(),
      ),
      onGenerateRoute: PageRoutes.generateRoute,
    );
  }
}
