
import 'localization_manager.dart';

extension LocalizationExtension on String {
  String get tr => LocaleManager.controller?.localeJson?[this] ?? "Not Found -> $this";
}
