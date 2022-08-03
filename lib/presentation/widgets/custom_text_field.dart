import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/constants.dart';

class CustomTextField extends StatefulWidget {
  final bool isPasswordField;
  final TextEditingController textEditingController;
  final Function(String value) validFunction;

  const CustomTextField({
    required this.textEditingController,
    required this.validFunction,
    this.isPasswordField = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0.h),
      child: Opacity(
        opacity: 0.8,
        child: TextFormField(
          controller: widget.textEditingController,
          validator: (value) => widget.validFunction(value!),
          style: TextStyle(
            fontSize: 18,
          ),
          cursorHeight: 25.h,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: kLightGrey,
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    iconSize: 24,
                    splashColor: Colors.transparent,
                    icon: !isObscure
                        ? Icon(
                            Icons.visibility,
                            color: Colors.blueGrey.shade300,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.blueGrey.shade300,
                          ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  )
                : SizedBox(),
          ),
          obscureText: widget.isPasswordField ? isObscure : false,
        ),
      ),
    );
  }
}
