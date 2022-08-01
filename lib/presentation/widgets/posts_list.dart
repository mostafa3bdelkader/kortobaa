import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/constants.dart';
import 'package:kortobaa/presentation/widgets/post_widget.dart';

class PostsList extends StatelessWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            PostWidget(
              image: 'assets/images/random_pic(2).jpg',
            ),
            PostWidget(
              image: 'assets/images/random_pic(3).jpg',
            ),
            PostWidget(
              image: 'assets/images/random_pic(1).jpg',
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.sh, horizontal: 0.1.sw),
          child: FloatingActionButton(
            onPressed: () {
              buildShowDialog(context);
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          scrollable: true,
          contentPadding: EdgeInsets.all(8.r),
          content: Container(
            height: 320.h,
            width: 344.w,
            child: Column(
              children: [
                Container(
                  height: 157.h,
                  width: 328.w,
                  decoration: BoxDecoration(
                    color: kLightGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Color(0xffC7DCE5),
                        size: 80,
                      ),
                      Text(
                        'رفع صورة',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'اكتب تعليقا حول الصورة',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                TextField(
                  style: TextStyle(fontSize: 18, color: kNavyBlue, height: 1.5),
                  decoration: InputDecoration(),
                  maxLines: 2,
                  maxLength: 120,
                  cursorHeight: 30,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('تجاهل')),
            SizedBox(
              width: 77.w,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('نشر'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
