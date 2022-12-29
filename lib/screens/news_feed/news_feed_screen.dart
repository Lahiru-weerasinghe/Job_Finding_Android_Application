import "package:flutter/material.dart";
import 'package:linkup/components/add_post_feed.dart';
import 'package:linkup/models/post_model.dart';
import 'package:provider/provider.dart';
import 'package:linkup/components/post_card.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/providers/post_provider.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key key}) : super(key: key);

  @override
  NewsFeedScreenState createState() => NewsFeedScreenState();
}

class NewsFeedScreenState extends State<NewsFeedScreen> {
  Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = Provider.of<PostProvider>(context, listen: false).getPosts();
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
              child: FutureBuilder<List<Post>>(
                future: posts,
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
            const AddPostFeed(),
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
          return PostCard(
            fullName: snapshot.data[index].fullName,
            description: snapshot.data[index].description,
            position: snapshot.data[index].position,
            postImage: snapshot.data[index].postImage,
            profileImageURL: snapshot.data[index].profileImageURL,
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
      posts = Provider.of<PostProvider>(context, listen: false).getPosts();
    });
  }
}
