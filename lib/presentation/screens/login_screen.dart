import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kortobaa/helpers/http_exception.dart';
import 'package:kortobaa/presentation/screens/registration_screen.dart';
import 'package:kortobaa/presentation/widgets/orange_button.dart';
import 'package:kortobaa/providers/auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
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
                        'البريد الالكتروني',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    CustomTextField(
                        textEditingController: _emailController,
                        validFunction: (value) {
                          if (!EmailValidator.validate(value)) {
                            return 'من فضلك ادخل بريد الكتروني صحيح';
                          } else {
                            return null;
                          }
                        }),
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
                    CustomTextField(
                        textEditingController: _passwordController,
                        validFunction: (value) {
                          if (value.length > 1 && value.length < 8) {
                            return 'اقل عدد احرف 8';
                          } else if (value.isEmpty) {
                            return 'من فضلك ادخل كلمة سر';
                          } else {
                            return null;
                          }
                        },
                        isPasswordField: true),
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
                        _submit(context);
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
      ),
    );
  }

  void _submit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Lottie.network(
          'https://assets2.lottiefiles.com/packages/lf20_p5dchitl.json',
        ),
      );

      await Provider.of<AuthProvider>(context, listen: false).signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } on CustomHttpException catch (error) {
      var errorMessage = 'فشل التسجيل';
      if (error.toString().contains('email-already-in-use')) {
        errorMessage = 'البريد مستخدم من قبل';
      } else if (error.toString().contains('invalid-email')) {
        errorMessage = 'هذا البريد غير صالح';
      } else if (error.toString().contains('invalid-password')) {
        errorMessage = 'كلمة السر غير صالحة';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (error) {
      const errorMessage = 'من فضلك حاول في وقت لاحق';
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
          ),
        ),
      );
    } finally {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
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
