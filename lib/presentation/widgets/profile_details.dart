import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 218.h,
              width: double.infinity,
              child: Image.asset(
                'assets/images/random_pic(4).jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0.14.sh,
              child: Container(
                height: 0.3.sh,
                width: 0.3.sh,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/Ellipse 1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 0.125.sh,
        ),
        Text(
          'اسم المستخدم',
          style: TextStyle(
              color: kNavyBlue, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'User99@gmail.com',
          style: TextStyle(
            color: kGrey,
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 0.08.sh,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularOrangeButton(
                icon: Icons.edit,
                title: 'تعديل بياناتي',
                onTap: () {},
              ),
              CircularOrangeButton(
                icon: Icons.settings,
                title: 'الإعدادات',
                onTap: () {},
              ),
              CircularOrangeButton(
                icon: Icons.star,
                title: 'المفضلة',
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CircularOrangeButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String title;
  const CircularOrangeButton({
    required this.onTap,
    required this.icon,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: kLightGrey,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                color: kOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: kOffWhite,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: kNavyBlue),
            )
          ],
        ),
      ),
    );
  }
}
