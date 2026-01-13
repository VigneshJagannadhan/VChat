import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';

class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  Failure? _error;

  bool get isLoading => _isLoading;
  Failure? get getError => _error;

  @protected
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @protected
  void emitError(Failure failure) {
    _error = failure;
    log("BaseProvider : EmitError : ${_error?.message}");
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((v) {
      _error = null;
    });
  }

  @override
  void dispose() {
    _error = null;
    super.dispose();
  }

  void init() {}
}
