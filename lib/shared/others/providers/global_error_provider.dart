import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/others/providers/base_provider.dart';

class GlobalErrorProvider extends BaseProvider {
  Failure? _error;
  Failure? get error => _error;

  void emit(Failure failure) {
    _error = failure;
    notifyListeners();
    _error = null;
  }
}
