import 'package:flutter/material.dart';

import '../core/theme.dart';

buildShowSnackBarService(BuildContext context, {required String msz}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msz),
      backgroundColor: AppColor.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
    ),
  );
}
