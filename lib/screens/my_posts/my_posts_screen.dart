import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/models/post_model.dart';
import 'package:linkup/providers/post_provider.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:linkup/screens/my_posts/edit_my_post.dart';
import 'package:linkup/screens/my_posts/my_post_card.dart';
import 'package:provider/provider.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({Key key}) : super(key: key);

  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  Future<List<Post>> userPosts;
  PostProvider _postProvider;
  UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _postProvider = context.read<PostProvider>();

    userPosts =
        Provider.of<UserProvider>(context, listen: false).getUserPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Posts",
          style: TextStyle(fontFamily: fontFamilySFPro),
        ),
        backgroundColor: colorDarkMidGround,
        elevation: 0.0,
      ),
      backgroundColor: colorDarkBackground,
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 10),
          child: FutureBuilder<List<Post>>(
            future: userPosts,
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
              child: MyPostCard(
                fullName: snapshot.data[index].fullName,
                description: snapshot.data[index].description,
                position: snapshot.data[index].position,
                postImage: snapshot.data[index].postImage,
                profileImageURL: snapshot.data[index].profileImageURL,
              ),
              endActionPane: ActionPane(
                dismissible: DismissiblePane(
                  onDismissed: () {
                    _postProvider.deletePost(context, snapshot.data[index].id);
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
                          builder: (context) => EditPost(
                            id: snapshot.data[index].id,
                            description: snapshot.data[index].description,
                            imageURL: snapshot.data[index].postImage,
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
                'assets/images/post.png',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'You have not publish any posts to LinkUp',
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
      userPosts = Provider.of<UserProvider>(context, listen: false)
          .getUserPosts(context);
    });
  }
}
