import 'package:flutter/material.dart';
import 'package:trendingfood_flutter/widget/dialogs/exit_confirmation.dart';
import 'package:trendingfood_flutter/widget/dialogs/log_failure.dart';

class DialogHelper {

  static exit(context) => showDialog(context: context, builder: (context) => ExitConfirmationDialog());

  static logFailure(context) => showDialog(context: context, builder: (context) => LogFailureInfoDialog());

  static connectionFailure(context) => showDialog(context: context, builder: (context) => LogFailureInfoDialog());

}