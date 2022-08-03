import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

import '../../helpers/constants.dart';

class PostWidget extends StatefulWidget {
  final String image;
  final String details;
  final String postId;
  bool isBookmarked;
  var likes;

  PostWidget({
    required this.postId,
    required this.likes,
    required this.details,
    required this.image,
    required this.isBookmarked,
    Key? key,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  var isLiked;
  late int likesCount;

  int getLikeCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  void initState() {
    likesCount = getLikeCount(widget.likes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (widget.likes[userId] == true);
    return SizedBox(
      height: 390.h,
      width: 328.w,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(20.h),
        shadowColor: kLightGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Color(0xffC7DBE4),
                    ),
                    backgroundColor: Color(0xffEBF0F2),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(
                      Icons.share,
                      color: kGrey,
                      size: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      onPressed: () async {
                        if (widget.isBookmarked) {
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.postId)
                              .update({'isFavorite': false});
                          setState(() {
                            widget.isBookmarked = false;
                          });
                        } else if (!widget.isBookmarked) {
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.postId)
                              .update({'isFavorite': true});
                          setState(() {
                            widget.isBookmarked = true;
                          });
                        }
                      },
                      splashRadius: 20,
                      icon: widget.isBookmarked
                          ? Icon(
                              Icons.bookmark,
                              color: Colors.blue.shade700,
                              size: 24,
                            )
                          : Icon(
                              Icons.bookmark,
                              color: kGrey,
                              size: 24,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: LikeButton(
                      size: 24,
                      isLiked: isLiked,
                      circleColor: CircleColor(
                        start: kNavyBlue,
                        end: kOrange,
                      ),
                      onTap: (val) async {
                        if (isLiked) {
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.postId)
                              .update({'likes.$userId': false});
                          setState(() {
                            likesCount -= 1;
                            isLiked = false;
                            widget.likes[userId] = false;
                          });
                        } else if (!isLiked) {
                          await FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.postId)
                              .update({'likes.$userId': true});
                          setState(() {
                            likesCount += 1;
                            isLiked = true;
                            widget.likes[userId] = true;
                          });
                        }
                        return null;
                      },
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: kOrange,
                        dotSecondaryColor: kNavyBlue,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.thumb_up_alt_rounded,
                          color: isLiked ? kNavyBlue : kGrey,
                          size: 24,
                        );
                      },
                      likeCount: likesCount,
                      countPostion: CountPostion.bottom,
                      countBuilder: (int? count, bool isLiked, String text) {
                        var color =
                            isLiked ? Colors.deepPurpleAccent : Colors.grey;
                        Widget result;
                        if (count == 0) {
                          result = Text(
                            "0",
                            style: TextStyle(color: color),
                          );
                        } else
                          result = Container(
                            color: kLightGrey,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              text,
                              style: TextStyle(color: color, fontSize: 14),
                            ),
                          );
                        return result;
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    widget.image,
                    height: 200.h,
                    width: 316.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.details,
                  style: TextStyle(
                    fontSize: 16,
                    color: kNavyBlue,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
