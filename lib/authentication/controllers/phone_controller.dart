import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController textController = TextEditingController();
  String initialCountry = 'TZ';
  Rx<PhoneNumber> number = PhoneNumber(isoCode: 'TZ').obs;

  String phoneScreenTitle = "Phone Authentication";

  String phoneScreenHeaderlText =
      "Please enter your phone number to be registered";

  String phoneScreenNotThisAuth = "Other Sign up ?";

  String phoneScreenBack = "Options";

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber);

    this.number = number.obs;
  }

  bool submitPhone() {
    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      debugPrint(number.value.phoneNumber);
      return true;
    } else {
      debugPrint("Invalid number");
      return false;
    }
  }
}
