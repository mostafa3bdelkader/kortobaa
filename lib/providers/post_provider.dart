import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kortobaa/models/post.dart';

class PostsProvider with ChangeNotifier {
  Future addPost(Post newPost) async {
    final docUser = FirebaseFirestore.instance.collection('posts').doc();
    newPost.postId = docUser.id;
    final json = newPost.toJson();
    await docUser.set(json);
  }

  Stream<List<Post>> readPost() =>
      FirebaseFirestore.instance.collection('posts').snapshots().map(
            (snapshots) => snapshots.docs
                .map(
                  (doc) => Post.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
}
