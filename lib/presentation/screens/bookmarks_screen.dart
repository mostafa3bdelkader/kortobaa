import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../models/post.dart';
import '../../providers/post_provider.dart';
import '../widgets/post_widget.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'المحفوظات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kNavyBlue,
        elevation: 0,
      ),
      body: StreamBuilder<List<Post>>(
          stream: Provider.of<PostsProvider>(context).readPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data
                  ?.where((element) => element.isFavorite == true)
                  .toList();
              if (posts?.length == 0) {
                return Center(
                  child: Text('لا يوجد محفوظات'),
                );
              } else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: posts?.length,
                  itemBuilder: (context, index) => PostWidget(
                    isBookmarked: posts![index].isFavorite,
                    postId: posts[index].postId,
                    likes: posts[index].likes,
                    image: posts[index].image,
                    details: posts[index].details,
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
