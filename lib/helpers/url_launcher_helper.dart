import 'package:shortpal/constant_data.dart';
import 'package:shortpal/helpers/show_pop_up_dialog_helper.dart';
import 'package:shortpal/text_data.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  factory UrlLauncherHelper() {
    return _mainUrlLauncherHelper;
  }

  UrlLauncherHelper._internal();

  static final UrlLauncherHelper _mainUrlLauncherHelper =
      UrlLauncherHelper._internal();

  final ShowPopUpDialogHelper _showPopUpDialogHelper =
      ShowPopUpDialogHelper();

  Future<void> launchWebView(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      _showPopUpDialogHelper.showPopUpDialog(
        title: TextData.textSorry,
        content: ConstantData.somethingWentWrong,
      );
    }
  }
}
