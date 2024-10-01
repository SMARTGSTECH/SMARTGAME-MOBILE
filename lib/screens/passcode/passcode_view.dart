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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                context.read<PinEntryProvider>().pinStore.isNotEmpty &&
                        context.read<PinEntryProvider>().pinStore.length >= 2
                    ? 'Set recovery word for your account'
                    : ' ${context.read<PinEntryProvider>().hasSetPin ? 'Enter PIN' : context.read<PinEntryProvider>().pinStore.isNotEmpty ? 'Confirm Pin' : 'Create Pin'} to Access Your Account',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorConfig.iconColor,
                ),
              ),
              SizedBox(height: 20.h),
              context.read<PinEntryProvider>().pinStore.isNotEmpty &&
                      context.read<PinEntryProvider>().pinStore.length >= 2
                  ? TextField(
                      onChanged: (val) {
                        print(val);
                        context
                            .read<PinEntryProvider>()
                            .recovertyListiner(val.trim());
                      },
                      style: const TextStyle(color: Colors.white),
                      //  controller: widget.controller,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: ColorConfig.iconColor.withOpacity(0.7)),
                        labelText: 'Hint: Enter a word you can easily remember',
                        border: OutlineInputBorder(),
                      ),
                    ).paddingSymmetric(horizontal: 20.h)
                  : _PinDisplay(),
              SizedBox(height: 10.h),
              context.read<PinEntryProvider>().pinStore.isNotEmpty &&
                      context.read<PinEntryProvider>().pinStore.length >= 2
                  ? Container()
                  : IconButton(
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
              context.read<PinEntryProvider>().pinStore.isNotEmpty &&
                      context.read<PinEntryProvider>().pinStore.length >= 2
                  ? Container()
                  : _Keypad(),
            ],
          ),
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
    return context.read<PinEntryProvider>().pinStore.isNotEmpty &&
            context.read<PinEntryProvider>().pinStore.length >= 2
        ? ElevatedButton(
            onPressed: context.watch<PinEntryProvider>().recoveryword.isNotEmpty
                ? () {
                    // toast('');
                    // print(context.read<PinEntryProvider>().isPinComplete);
                    if (false) {
                      const MainScreenMobile().launch(context);
                      return;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 0),
                          content: Text(
                            'Authorizing',
                            style: TextStyle(
                                color: ColorConfig.iconColor, fontSize: 15.sp),
                          ),
                          backgroundColor: ColorConfig.appBar,
                        ),
                      );
                      context.read<PinEntryProvider>().addDigitToStore(
                          context.read<PinEntryProvider>().recoveryword,
                          context);
                    }

                    // Handle login action
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  context.watch<PinEntryProvider>().recoveryword.isNotEmpty
                      ? ColorConfig.appBar
                      : Colors.grey.withOpacity(0.12),
              // disabledForegroundColor: Colors.grey.withOpacity(0.38),
              // disabledBackgroundColor:
              //     context.watch<PinEntryProvider>().recoveryword.isNotEmpty
              //         ? ColorConfig.appBar
              //         : Colors.grey.withOpacity(0.12), // Disabled color
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text(
              'Set recovery word',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        : ElevatedButton(
            onPressed: context.watch<PinEntryProvider>().isPinComplete
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 0),
                        content: Text(
                          'Authorizing',
                          style: TextStyle(
                              color: ColorConfig.iconColor, fontSize: 15.sp),
                        ),
                        backgroundColor: ColorConfig.appBar,
                      ),
                    );

                    // toast('');
                    // print(context.read<PinEntryProvider>().isPinComplete);
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
                                  color: ColorConfig.iconColor,
                                  fontSize: 15.sp),
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
              disabledForegroundColor: Colors.grey.withOpacity(0.38),
              disabledBackgroundColor:
                  Colors.grey.withOpacity(0.12), // Disabled color
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              context.read<PinEntryProvider>().hasSetPin
                  ? 'Login'
                  : context.read<PinEntryProvider>().pinStore.isNotEmpty &&
                          context.read<PinEntryProvider>().pinStore.length >= 2
                      ? 'Set recovery word'
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
              ? context.read<PinEntryProvider>().hasSetPin
                  ? IconButton(
                      onPressed: () {
                        showBottomSheetRecovery(context);
                        // context.read<PinEntryProvider>().deleteDigit();
                      },
                      icon: Icon(Icons.lock_reset,
                          size: 28.sp, color: ColorConfig.yellow),
                    )
                  : Container()
              : ElevatedButton(
                  onPressed: () {
                    context.read<PinEntryProvider>().addDigit(digits[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorConfig.appBar,
                    backgroundColor: ColorConfig.iconColor,
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

void showBottomSheetRecovery(BuildContext context) {
  final TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    ///  showDragHandle: true,
    backgroundColor: ColorConfig.scaffold,
    isDismissible: false,
    // backgroundColor: Colors.amber,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Recoverybottomsheet(controller: controller);
    },
  );
}

class Recoverybottomsheet extends StatefulWidget {
  const Recoverybottomsheet({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<Recoverybottomsheet> createState() => _RecoverybottomsheetState();
}

class _RecoverybottomsheetState extends State<Recoverybottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      // color: ColorConfig.appBar,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap content in SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.cancel).onTap(() {
                    Navigator.pop(context);
                  })
                ],
              ),
              Text(
                'Enter your recovery word',
                style: TextStyle(fontSize: 18.sp),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (val) {
                  print(val);
                },
                style: const TextStyle(color: Colors.white),
                controller: widget.controller,
                decoration: InputDecoration(
                  labelStyle:
                      TextStyle(color: ColorConfig.iconColor.withOpacity(0.7)),
                  labelText: 'Hint: word you inputted when setting up your pin',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConfig.appBar, // Background color
                  // Text color
                ),
                onPressed: () {
                  print(context.read<PinEntryProvider>().recoveryword);
                  String inputText = widget.controller.text;
                  if (widget.controller.text ==
                      context.read<PinEntryProvider>().recoveryword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 5),
                        content: Text(
                          'Your PIN is ${context.read<PinEntryProvider>().userPin}',
                          style: TextStyle(
                              color: ColorConfig.iconColor, fontSize: 15.sp),
                        ),
                        backgroundColor: ColorConfig.appBar,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 5),
                        content: Text(
                          'Incorrect recovery word',
                          style: TextStyle(
                              color: ColorConfig.iconColor, fontSize: 15.sp),
                        ),
                        backgroundColor: ColorConfig.appBar,
                      ),
                    );
                  }

                  Navigator.pop(context); // Close the bottom sheet
                  // print('User input: $inputText'); // For demonstration
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: ColorConfig.iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnScreenKeyboard extends StatefulWidget {
  @override
  _OnScreenKeyboardState createState() => _OnScreenKeyboardState();
}

class _OnScreenKeyboardState extends State<OnScreenKeyboard> {
  String _input = "";

  // List of letters from A to Z
  final List<String> _letters =
      List.generate(26, (index) => String.fromCharCode(65 + index));

  void _onKeyPress(String letter) {
    setState(() {
      _input += letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On-Screen Keyboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the typed input
          Text(
            'Typed: $_input',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),

          // Create a GridView for letters A-Z
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6, // Number of columns in the grid
                childAspectRatio: 2, // Ratio of width to height for each button
              ),
              itemCount: _letters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _onKeyPress(_letters[index]),
                    child: Text(
                      _letters[index],
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
