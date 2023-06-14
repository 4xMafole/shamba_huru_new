import 'package:animate_do/animate_do.dart';
import 'package:argon_buttons_flutter_fix/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_pinput/reactive_pinput.dart';
import 'package:shamba_huru/authentication/controllers/otp_controller.dart';
import 'package:shamba_huru/main.dart';

import '../../content/views/content_view.dart';
import '../../extras/utils/app_colors.dart';

class OtpView extends StatelessWidget {
  OtpView({Key? key}) : super(key: key);

  final OtpController _controller = Get.put(OtpController());

  @override
  SafeArea build(BuildContext context) {
    return SafeArea(
      child: ReactiveForm(
        formGroup: _controller.otpForm,
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: Get.height * 0.2,
                ),
                child: _screenContent(context),
              ),
            ],
          ),
          floatingActionButton: _verifyButton(),
        ),
      ),
    );
  }

  Column _screenContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //  Screen title: Verification
        Center(
          child: Text(
            _controller.otpScreenTitle,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.deepGreen,
                ),
          ),
        ),
        // Vertical space
        const SizedBox(height: 25.0),
        // Main text: Enter 6 digit code ...
        Center(
          child: Text(
            // Replace text with Get.arguments or from variable: wahtever your use case
            _controller.otpScreenHeaderlText + " +255...05",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: AppColor.pullmanBrown,
                ),
          ),
        ),
        // Vertical space
        const SizedBox(height: 25.0),
        // Edit number link (return to login page on tap)
        Center(
          child: GestureDetector(
            // todo: Implement onTap: Navigate back to phone registration screen
            onTap: () {
              Get.back();
            },
            child: Text(
              _controller.otpScreenEditBtnText,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.paleGreen,
                  ),
            ),
          ),
        ),
        // Vertical space
        const SizedBox(height: 25.0),
        // Pin code text fields
        ReactivePinPut<String>(
          formControlName: _controller.otpControl,
          fieldsCount: 6,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          withCursor: true,
          autofocus: true,
          pinAnimationType: PinAnimationType.fade,
          submittedFieldDecoration: _pinPutDecoration(AppColor.deepGreen),
          selectedFieldDecoration: _pinPutDecoration(AppColor.deepGreen),
          followingFieldDecoration: _pinPutDecoration(AppColor.paleGreen),
          validationMessages: (control) => {
            ValidationMessage.required: _controller.requiresMsg,
            ValidationMessage.maxLength: _controller.minMaxMsg,
            ValidationMessage.minLength: _controller.minMaxMsg,
          },
        ),
        // Vertical space
        const SizedBox(height: 25.0),
        // Didn't receive code text & button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Text: Didn't receive code
            Text(
              _controller.otpScreenNotReceivedMsg,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColor.deepGreen),
            ),
            // Horizontal space
            const SizedBox(
              width: 10.0,
            ),
            // Resend again button
            _resendAgainTimerButton(context),
          ],
        ),
      ],
    );
  }

  // Function for pin code fields decoration
  BoxDecoration _pinPutDecoration(Color color) {
    return BoxDecoration(
      border: Border.all(
        color: color,
      ),
    );
  }

  // ! ===== Verify button =====
  ReactiveFormConsumer _verifyButton() {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: AppColor.paleGreen,
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed: form.valid
              ? () {
                  // todo: Call Api to verify otp code
                  Phoenix.rebirth(context);
                  Get.offAll(() => ContentView());

                  debugPrint("Submitted otp: " + _controller.getOtp());
                }
              : null,
          child: const Icon(Icons.arrow_forward_rounded, size: 30.0),
        );
      },
    );
  }

  // ! ==== Request again timer button ====
  ArgonTimerButton _resendAgainTimerButton(BuildContext context) {
    return ArgonTimerButton(
      height: 20,
      width: MediaQuery.of(context).size.width * 0.30,
      minWidth: MediaQuery.of(context).size.width * 0.10,
      highlightColor: Colors.transparent,
      highlightElevation: 0,
      roundLoadingShape: true,
      splashColor: Colors.transparent,
      onTap: (startTimer, btnState) {
        if (btnState == ButtonState.Idle) {
          startTimer(_controller.otpScreenTimerValue);
        }
      },
      initialTimer: _controller.otpScreenTimerValue,
      child: Text(
        "Resend Code",
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppColor.paleGreen,
            ),
      ),
      loader: (timeLeft) {
        return Text("$timeLeft",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.black,
                ));
      },
      borderRadius: 5.0,
      color: Colors.transparent,
      elevation: 0,
    );
  }
}
