import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kortobaa/presentation/screens/registration_screen.dart';
import 'package:kortobaa/presentation/widgets/orange_button.dart';

import '../../constants.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Text(
                      'تسجيل الدخول',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'اسم المستخدم',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  CustomTextField(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'كلمة المرور',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  CustomTextField(isPasswordField: true),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'نسيت كلمة المرور ؟',
                      style: TextStyle(
                        color: kNavyBlue,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  OrangeButton(
                    label: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.2,
                          color: kDarKGrey,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        'أو',
                        style: TextStyle(fontSize: 14, color: kDarKGrey),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.2,
                          color: kDarKGrey,
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 28.h),
                    child: Text(
                      'إذا لم يكن لديك حساب قم بالتسجيل',
                      style: TextStyle(
                        fontSize: 14,
                        color: kDarKGrey,
                      ),
                    ),
                  ),
                  RegistrationButton(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrationButton extends StatelessWidget {
  final VoidCallback onTap;
  const RegistrationButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: FaIcon(
          FontAwesomeIcons.userPlus,
          size: 14,
        ),
        label: Text(
          'تسجيل حساب جديد',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 15.h),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: kOrange,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
