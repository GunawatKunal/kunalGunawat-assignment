import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_reg_demo/core/theme.dart';

class ExitCheck extends StatelessWidget {
  final Widget widget;
  const ExitCheck(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (_) => exitAlertDialog(_),
        );
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: widget,
      ),
    );
  }
}

Widget exitAlertDialog(BuildContext context, {title = 'Are you sure you want to exit app?', no = true}) {
  return AlertDialog(
    backgroundColor: Colors.white,
    content: Text(title, style: const TextStyle(color: AppColor.primaryColor)),
    actions: <Widget>[
      if (no)
        TextButton(
          child: const Text('No', style: TextStyle(color: AppColor.primaryColor)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      TextButton(
        child: const Text('Yes, exit', style: TextStyle(color: AppColor.primaryColor)),
        onPressed: () => SystemNavigator.pop(),
      ),
    ],
  );
}
