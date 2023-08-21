import 'package:flutter/cupertino.dart';

import '../../loaders/custom_dialog.dart';
import '../api_services/api_exceptions.dart';

class BaseController {
  void handleError(error, BuildContext context) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      CustomDialogBox.showErrorDialog(
        description: message,
        context: context,
      );
    } else if (error is FetchDataException) {
      var message = error.message;
      CustomDialogBox.showErrorDialog(description: message, context: context);
    } else if (error is ApiNotRespondingException) {
      CustomDialogBox.showErrorDialog(
          description: 'Oops! It took longer to respond.', context: context);
    }
  }

  showLoading([String? message]) {
    CustomDialogBox.showLoading(message);
  }

  hideLoading() {
    CustomDialogBox.hideLoading();
  }
}
