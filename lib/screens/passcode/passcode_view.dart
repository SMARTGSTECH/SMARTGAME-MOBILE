import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/main_screen/mobile.dart';
import 'package:smartbet/screens/passcode/pass_code_view_model.dart';
import 'package:smartbet/utils/config/color.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  State<PinEntryScreen> createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  @override
  void initState() {
    print("dsldsldks");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ' ${context.read<PinEntryProvider>().hasSetPin ? 'Enter PIN' : context.read<PinEntryProvider>().pinStore.isNotEmpty ? 'Confirm Pin' : 'Create Pin'} to Access Your Account',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorConfig.iconColor,
              ),
            ),
            SizedBox(height: 20.h),
            _PinDisplay(),
            SizedBox(height: 10.h),
            IconButton(
              icon: Icon(
                context.watch<PinEntryProvider>().isObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: ColorConfig.yellow,
              ),
              onPressed: () {
                context.read<PinEntryProvider>().toggleObscure();
              },
            ),
            SizedBox(height: 20.h),
            _LoginButton(),
            SizedBox(height: 20.h),
            _Keypad(),
          ],
        ),
      ),
    );
  }
}

class _PinDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        context.watch<PinEntryProvider>().pinLength,
        (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            width: 30.w,
            height: 50.h,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.w,
                  color: ColorConfig.iconColor,
                ),
              ),
            ),
            child: Center(
              child: Text(
                context.watch<PinEntryProvider>().pin.length > index
                    ? context.watch<PinEntryProvider>().isObscured
                        ? '•' // Obscure character
                        : context.watch<PinEntryProvider>().pin[index]
                    : '',
                style: TextStyle(
                  fontSize: !context.watch<PinEntryProvider>().isObscured
                      ? 30.sp
                      : 52.sp, // Larger size for the • character
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: context.watch<PinEntryProvider>().isPinComplete
          ? () {
              print(context.read<PinEntryProvider>().isPinComplete);
              if (context.read<PinEntryProvider>().hasSetPin &&
                  context.read<PinEntryProvider>().userPin ==
                      context.read<PinEntryProvider>().pin) {
                const MainScreenMobile().launch(context);
                return;
              } else {
                if (context.read<PinEntryProvider>().hasSetPin) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Incorrect PIN!',
                        style: TextStyle(
                            color: ColorConfig.iconColor, fontSize: 15.sp),
                      ),
                      backgroundColor: ColorConfig.appBar,
                    ),
                  );
                  return;
                }
                context.read<PinEntryProvider>().addDigitToStore(
                    context.read<PinEntryProvider>().pin, context);
              }

              // Handle login action
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConfig.appBar,
        disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Disabled color
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Text(
        context.read<PinEntryProvider>().hasSetPin
            ? 'Login'
            : context.read<PinEntryProvider>().pinStore.isNotEmpty
                ? 'Confirm Pin'
                : 'Create Pin',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  final List<String> digits = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0'
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: digits.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
      ),
      itemBuilder: (context, index) {
        if (index == digits.length) {
          return IconButton(
            onPressed: () {
              context.read<PinEntryProvider>().deleteDigit();
            },
            icon: Icon(Icons.backspace, color: ColorConfig.yellow),
          );
        } else {
          return digits[index] == ''
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    context.read<PinEntryProvider>().addDigit(digits[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConfig.appBar, backgroundColor: ColorConfig.iconColor,
                    shape: CircleBorder(),
                  ),
                  child: Text(
                    digits[index],
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ).paddingTop(2.h);
        }
      },
    );
  }
}
