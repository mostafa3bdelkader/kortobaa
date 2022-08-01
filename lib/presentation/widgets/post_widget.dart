import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

import '../../constants.dart';

class PostWidget extends StatelessWidget {
  final String image;
  const PostWidget({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      splashRadius: 20,
                      icon: Icon(
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
                      circleColor: CircleColor(
                        start: kNavyBlue,
                        end: kOrange,
                      ),
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
                      likeCount: 5,
                      countPostion: CountPostion.bottom,
                      countBuilder: (int? count, bool isLiked, String text) {
                        var color =
                            isLiked ? Colors.deepPurpleAccent : Colors.grey;
                        Widget result;
                        if (count == 0) {
                          result = Text(
                            "Like",
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
                  child: Image.asset(
                    image,
                    height: 200.h,
                    width: 316.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص',
                style: TextStyle(
                  fontSize: 14,
                  color: kNavyBlue,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
