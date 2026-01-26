import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';
import 'package:vignesh_project_01/shared/domain/repositories/update_repository.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_states.dart';

class UpdateCubit extends Cubit<UpdateStates> {
  UpdateRepository updateRepository;
  StorageService storageService;

  UpdateCubit({required this.updateRepository, required this.storageService})
    : super(UpdateInitial());

  Future<void> checkForUpdate() async {
    emit(UpdateLoading());

    var cachedUpdate = updateRepository.getCachedUpdate();
    cachedUpdate.fold((failure) => null, (updateEntity) async {
      checkIfOutdated(updateEntity, isSyncing: true);
    });

    var result = await updateRepository.syncUpdate();
    result.fold(
      (failure) {
        if (state is UpdateLoaded) {
          final currentState = state as UpdateLoaded;
          emit(
            UpdateLoaded(
              updateEntity: currentState.updateEntity,
              isUpdateAvailable: currentState.isUpdateAvailable,
              isSyncing: false,
            ),
          );
        } else {
          emit(UpdateFailure(failure: failure));
        }
      },
      (updateEntity) {
        checkIfOutdated(updateEntity, isSyncing: false);
      },
    );
  }

  void checkIfOutdated(UpdateEntity updateEntity, {required bool isSyncing}) {
    var isUpdateAvailable = updateEntity.isVersionOutdated(
      currentVersion: storageService.fetchVersion() ?? '0',
    );
    emit(
      UpdateLoaded(
        updateEntity: updateEntity,
        isUpdateAvailable: isUpdateAvailable,
        isSyncing: isSyncing,
      ),
    );
  }
}
