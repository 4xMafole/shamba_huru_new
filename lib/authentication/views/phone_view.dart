import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shamba_huru/authentication/controllers/phone_controller.dart';
import 'package:shamba_huru/authentication/views/otp_view.dart';

import '../../extras/utils/app_colors.dart';

class PhoneView extends StatelessWidget {
  PhoneView({Key? key}) : super(key: key);
  final PhoneController _controller = Get.put(PhoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _screenContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //  Screen title: Verification
        Center(
          child: Text(
            _controller.phoneScreenTitle,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.deepGreen,
                ),
          ),
        ),
        const SizedBox(height: 25.0),
        Center(
          child: Text(
            _controller.phoneScreenHeaderlText,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  color: AppColor.pullmanBrown,
                ),
          ),
        ),
        const SizedBox(height: 25.0),
        phoneForm(),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _controller.phoneScreenNotThisAuth,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColor.deepGreen),
            ),
            const SizedBox(
              width: 10.0,
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                _controller.phoneScreenBack,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColor.paleGreen),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget phoneForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              //Just checking the number changes
              _controller.getPhoneNumber(number.phoneNumber!);
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoFocus: true,
            autoValidateMode: AutovalidateMode.always,
            selectorTextStyle: TextStyle(color: AppColor.deepGreen),
            initialValue: _controller.number.value,
            textFieldController: _controller.textController,
            formatInput: true,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ! ===== Verify button =====
  ElevatedButton _verifyButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: AppColor.paleGreen,
        padding: const EdgeInsets.all(10.0),
      ),
      onPressed: () {
        if (_controller.submitPhone()) {
          Get.to(OtpView());
        }
      },
      child: const Icon(Icons.arrow_forward_rounded, size: 30.0),
    );
  }
}
