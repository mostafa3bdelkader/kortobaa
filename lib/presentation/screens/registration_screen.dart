import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/constants.dart';
import 'package:kortobaa/presentation/screens/home_screen.dart';
import 'package:kortobaa/presentation/widgets/custom_text_field.dart';
import 'package:kortobaa/presentation/widgets/orange_button.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إنشاء حساب',
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: kDarKGrey,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'البريد الالكتروني',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                CustomTextField(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'كلمة المرور',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                CustomTextField(isPasswordField: true),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'تأكيد كلمة المرور',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                CustomTextField(isPasswordField: true),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'الاسم الأول',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                CustomTextField(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'الاسم الأخير',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                CustomTextField(),
                SizedBox(
                  height: 20.h,
                ),
                OrangeButton(
                    label: 'إنشاء حساب',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
