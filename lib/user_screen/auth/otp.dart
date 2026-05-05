import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uday_bharat/user_screen/dashborad/dashboard.dart';
import 'package:uday_bharat/user_screen/provider/view_model/auth_provider.dart';
import 'package:uday_bharat/utils/color.dart';
import 'package:uday_bharat/utils/custom_button.dart';
import 'package:uday_bharat/utils/cutom_text.dart';
import 'package:uday_bharat/utils/session.dart';
import 'package:uday_bharat/utils/size.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  TextEditingController? controller = TextEditingController();

  int _secondsRemaining = 30;
  Timer? _timer;
  bool _showResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();

    // Start listening for SMS codes (sms_autofill)
    listenForCode();
    // Optionally: print app signature so you can include it in the SMS sent by your server
    SmsAutoFill().getAppSignature.then((signature) {
      // send this signature to your server and append to the SMS.
      // print('App signature: $signature');
    });
  }

  @override
  void codeUpdated() {
    // This is called when sms_autofill detects a code.
    // 'code' is provided by CodeAutoFill mixin.
    if (code != null && code!.trim().isNotEmpty) {
      final pin = code!.trim();
      final auth = Provider.of<AuthProvider>(context, listen: false);
      // Fill the provider's controller so Pinput shows the value
      auth.otpController.text = pin;

      // Auto submit (ensure provider uses the controller's text)
      // add a slight delay to let UI update
      Future.delayed(Duration(milliseconds: 200), () {
        auth.verifyOtpApi(context);
      });
    }
  }

  void startTimer() {
    _secondsRemaining = 30;
    _showResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _showResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    // stop listening for code
    cancel(); // from CodeAutoFill mixin
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyFontSize fontSize = MyFontSize(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: fontSize.h / 2.6,
                width: fontSize.w,
                color: Colors.yellow,
                padding: const EdgeInsets.only(top: 90, right: 40, left: 40),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    color: AppColors.white,
                  ),
                  child: Image.asset('assets/deleveyBoy.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: fontSize.h * 0.02),
                  CustomText('OTP Verification',
                      fontFamily: 'Archivo Black',
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  SizedBox(height: fontSize.h * 0.03),
                  Consumer<AuthProvider>(builder: (context, value, child) {
                    return  CustomText('We have sent an OTP to +91${value.mobileController.text}');
                  },),
                  const CustomText('Please enter it below'),
                ],
              ),
              SizedBox(height: fontSize.h * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return Pinput(
                          length: 6,
                          controller: value.otpController,
                          // keep other Pinput styling param as before
                          // optionally allow platform autofill hint:
                          autofillHints: const [AutofillHints.oneTimeCode],
                          onCompleted: (pin)async {
                            // manual typing completed -> verify
                            value.verifyOtpApi(context);
                          },
                        );
                      },
                    ),
                    SizedBox(height: fontSize.h * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText("Didn't receive an OTP: "),
                        _showResend
                            ? GestureDetector(
                          onTap: () {
                            startTimer();
                            Provider.of<AuthProvider>(context, listen: false)
                                .resentOtp(context);
                          },
                          child: const CustomText(
                            'Resend OTP',
                            color: AppColors.appColor,
                            decorationColor: AppColors.appColor,
                          ),
                        )
                            : CustomText(
                          'Resend in 00:${_secondsRemaining.toString().padLeft(2, '0')}',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: fontSize.h * 0.03),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                isLoading: value.isLoading,
                onPressed: () async {
                    value.verifyOtpApi(context);
                },
                title: 'Verify OTP',
              ),

            );
          },
        ),
      ),
    );
  }
}
