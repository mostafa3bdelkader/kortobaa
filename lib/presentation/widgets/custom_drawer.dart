import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        maxRadius: 30,
                        child: Icon(
                          Icons.person,
                          color: kOffWhite,
                          size: 40,
                        ),
                        backgroundColor: kGrey,
                      ),
                    ),
                    Text(
                      'احمد كرم',
                      style: TextStyle(
                        fontSize: 18,
                        color: kOffWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: kNavy,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: kNavy,
              ),
              title: Text(
                'الرئيسية',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Divider(
              indent: 0.1.sw,
              endIndent: 0.1.sw,
              color: kGrey,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: kNavy,
              ),
              title: Text(
                'حسابي',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Divider(
              indent: 0.1.sw,
              endIndent: 0.1.sw,
              color: kGrey,
            ),
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: kNavy,
              ),
              title: Text(
                'المحفوظات',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
