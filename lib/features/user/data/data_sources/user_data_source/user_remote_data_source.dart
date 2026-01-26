import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source/user_data_source.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';
import 'package:vignesh_project_01/features/user/data/models/user_response/user_response_model.dart';

class UserRemoteDataSourcesImpl extends UserRemoteDataSources {
  ApiService apiService;
  UserRemoteDataSourcesImpl({required this.apiService});

  @override
  Future<Either<Failure, UserListResponseModel>> getUserList({
    String? search,
  }) async {
    var result = await apiService.get(
      route: AppUrls.users,
      query: (search != null && search != "") ? {"search": search} : null,
    );
    return result.map(
      (response) => UserListResponseModel.fromJson(response.data),
    );
  }

  @override
  Future<Either<Failure, UserModel>> getProfileDetail() async {
    var result = await apiService.get(route: AppUrls.profile);
    return result.map((response) => UserModel.fromJson(response.data));
  }
}
