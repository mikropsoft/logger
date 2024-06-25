import 'package:flutter/material.dart';

String getVersion() {
  return "1.4.5";
}

String getDeviceType(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return (width < 500) ? 'phone' : 'tablet';
}

bool isTabView(BuildContext context) {
  return getDeviceType(context) == "tablet";
}

bool isLargestView(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  return (width > 1000);
}

String supportURL() {
  return "https://pyrix.vercel.app#request";
}

String supportEmail() {
  return "help.pyrix@gmail.com";
}
