import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/services/update_service.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';
import 'package:vignesh_project_01/shared/domain/repositories/update_repository.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_states.dart';

class UpdateCubit extends Cubit<UpdateStates> {
  UpdateRepository updateRepository;
  UpdateService updateService;

  UpdateCubit({required this.updateRepository, required this.updateService})
    : super(UpdateInitial());

  Future<void> checkForUpdate() async {
    emit(UpdateLoading());

    // 1. Try to load from cache first
    var cachedResult = updateRepository.getCachedUpdate();
    cachedResult.fold(
      (failure) => null, // Ignore cache missing on first run
      (updateEntity) => checkIfOutdated(updateEntity),
    );

    // 2. Sync from remote source
    var syncResult = await updateRepository.syncUpdate();
    syncResult.fold(
      (failure) {
        // Only show error if we haven't successfully loaded from cache
        if (state is! UpdateLoaded) {
          emit(UpdateFailure(failure: failure));
        }
      },
      (updateEntity) {
        checkIfOutdated(updateEntity);
      },
    );
  }

  void checkIfOutdated(UpdateEntity updateEntity) {
    var currentVersion = locator<StorageService>().fetchVersion() ?? '0';
    var isUpdateAvailable = isOutdated(
      currentVersion,
      updateEntity.latestVersion ?? '0',
    );
    emit(
      UpdateLoaded(
        updateEntity: updateEntity,
        isUpdateAvailable: isUpdateAvailable,
      ),
    );
  }

  bool isOutdated(String current, String latest) {
    List<int> parseVersion(String v) {
      final parts = v.split('.');
      final nums = parts.map((p) {
        final m = RegExp(r'\d+').firstMatch(p.trim());
        return m != null ? int.tryParse(m.group(0)!) ?? 0 : 0;
      }).toList();
      while (nums.length < 3) {
        nums.add(0);
      }
      return nums;
    }

    final c = parseVersion(current);
    final l = parseVersion(latest);

    for (int i = 0; i < 3; i++) {
      if (c[i] < l[i]) return true;
      if (c[i] > l[i]) return false;
    }
    return false;
  }
}
