// ignore_for_file: use_build_context_synchronously, unused_field, library_private_types_in_public_api, annotate_overrides, must_call_super, overridden_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocaleManager {
  static LocalizationController? controller;
}

class LocalizationController extends ChangeNotifier {
  late String _locale;
  late List<String> _supportedLocales;
  late _LocaleWidgetState _state;
  late String _localePath;
  late String _defaultLocale;
  late BuildContext _context;
  late String deviceLocale;

  String get locale => _locale;
  Map<String, dynamic>? localeJson;

  final _localDatabase = serviceLocator.get<LocalDatabase>();

  Future<void> init({
    required List<String> supportedLocales,
    required String localePath,
    required BuildContext context,
    required String defaultLocale,
    required _LocaleWidgetState state,
  }) async {
    _localePath = localePath;
    _supportedLocales = supportedLocales;
    _defaultLocale = defaultLocale;
    _state = state;
    _context = context;

    String? savedLocale = _localDatabase.getLanguage();
    if (savedLocale == null) {
      Locale deviceLocale = View.of(_context).platformDispatcher.locale;
      await _localDatabase.saveLanguage(deviceLocale.languageCode);
      _locale = deviceLocale.languageCode;
    } else {
      _locale = _localDatabase.getLanguage() ?? _defaultLocale;
    }
    await _setupLocales();
    await _initializeLocale();
  }

  Future<Map<String, dynamic>> _loadJsonData() async {
    try {
      final String jsonData = await rootBundle.loadString("$_localePath/$_locale.json");
      return json.decode(jsonData);
    } catch (e) {
      throw AppException(message: 'langError'.tr);
    }
  }

  Future<void> refreshJson() async {
    localeJson = await _loadJsonData();
    _state.notifyListeners();
    notifyListeners();
  }

  Future<void> _initializeLocale() async {
    localeJson = await _loadJsonData();
    _state.notifyListeners();
    notifyListeners();
  }

  Future<void> _setupLocales() async {
    if (!_supportedLocales.contains(_locale)) {
      _locale = _defaultLocale;
      await _localDatabase.saveLanguage(_locale);
    }
  }

  void dispose() {
    this;
  }

  Future<void> setLocale({required String language}) async {
    _locale = language;
    _setupLocales();
    _initializeLocale();
  }
}

class AppLocalization extends StatefulWidget {
  const AppLocalization({
    super.key,
    required this.supportedLocales,
    required this.child,
    required this.localePath,
    required this.defaultLocale,
  });

  final List<String> supportedLocales;
  final Widget child;
  final String localePath;
  final String defaultLocale;

  @override
  State<AppLocalization> createState() => _LocaleWidgetState();

  static _LocalizationProvider? of(BuildContext context) => _LocalizationProvider.of(context);
}

class _LocaleWidgetState extends State<AppLocalization> {
  late LocalizationController controller;
  late String locale;

  void notifyListeners() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.refreshJson();
  }

  @override
  void didUpdateWidget(covariant AppLocalization oldWidget) {
    controller.refreshJson();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller = LocalizationController();
    LocaleManager.controller = controller;
    locale = widget.defaultLocale;
    controller
        .init(
          localePath: widget.localePath,
          supportedLocales: widget.supportedLocales,
          context: context,
          defaultLocale: widget.defaultLocale,
          state: this,
        )
        .then(
          (value) => locale = controller.locale,
        );

    super.initState();
    controller.addListener(() {
      locale = controller.locale;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LocalizationProvider(locale, controller, child: widget.child);
  }
}

class _LocalizationProvider extends InheritedWidget {
  const _LocalizationProvider(this.currentLocale, this.controller, {required this.child}) : super(child: child);
  final String currentLocale;
  final Widget child;
  final LocalizationController controller;

  static _LocalizationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_LocalizationProvider>();
  }

  String get locale => controller.locale;

  /// Get fallback locale
  String? get fallbackLocale => controller._defaultLocale;

  // Locale get startLocale => parent.startLocale;

  /// Change app locale
  Future<void> setLocale(String locale) async {
    // Check old locale
    if (locale != controller.locale) {
      await controller.setLocale(language: locale);
    }
  }

  /// Getting device locale from platform
  String get deviceLocale => controller.deviceLocale;

  @override
  bool updateShouldNotify(_LocalizationProvider oldWidget) {
    return oldWidget.currentLocale != currentLocale;
  }
}
