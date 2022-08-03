import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kortobaa/helpers/constants.dart';
import 'package:kortobaa/helpers/http_exception.dart';
import 'package:kortobaa/presentation/screens/home_screen.dart';
import 'package:kortobaa/presentation/widgets/custom_text_field.dart';
import 'package:kortobaa/presentation/widgets/orange_button.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegistrationScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _submitPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  RegistrationScreen({Key? key}) : super(key: key);

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
        child: Form(
          key: _formKey,
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
                  CustomTextField(
                      textEditingController: _emailController,
                      validFunction: (value) {
                        if (!EmailValidator.validate(value)) {
                          return 'من فضلك ادخل بريد الكتروني صحيح';
                        } else {
                          return null;
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'كلمة المرور',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  CustomTextField(
                    textEditingController: _passwordController,
                    isPasswordField: true,
                    validFunction: (value) {
                      if (value.length > 1 && value.length < 8) {
                        return 'اقل عدد احرف 8';
                      } else if (value.isEmpty) {
                        return 'من فضلك ادخل كلمة سر';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'تأكيد كلمة المرور',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  CustomTextField(
                    textEditingController: _submitPasswordController,
                    isPasswordField: true,
                    validFunction: (value) {
                      if (value.length > 1 && value.length < 8) {
                        return 'اقل عدد احرف 8 ';
                      } else if (value.isEmpty) {
                        return 'من فضلك ادخل كلمة سر';
                      } else if (_passwordController.text.trim() !=
                          _submitPasswordController.text.trim()) {
                        return 'كلمة السر غير متطابقة';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'الاسم الأول',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  CustomTextField(
                    textEditingController: _firstNameController,
                    validFunction: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل الاسم الاول';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'الاسم الأخير',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  CustomTextField(
                    textEditingController: _lastNameController,
                    validFunction: (value) {
                      if (value.isEmpty) {
                        return 'من فضلك ادخل الاسم الاخير';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  OrangeButton(
                    label: 'إنشاء حساب',
                    onTap: () async => await _submit(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _submit(context) async {
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

      await Provider.of<AuthProvider>(context, listen: false).signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } on CustomHttpException catch (error) {
      print('print error here');
      print(error);
      var errorMessage = 'فشل التسجيل';
      if (error.toString().contains('email-already-in-use')) {
        errorMessage = 'البريد مستخدم من قبل';
      } else if (error.toString().contains('invalid-email')) {
        errorMessage = 'هذا البريد غير صالح';
      } else if (error.toString().contains('invalid-password')) {
        errorMessage = 'كلمة السر غير صالحة';
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
          ),
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      const errorMessage = 'من فضلك حاول في وقت لاحق';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
          ),
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
