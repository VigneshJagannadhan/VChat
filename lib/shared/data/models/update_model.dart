import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';

part 'update_model.g.dart';

@JsonSerializable()
class UpdateModel {
  String? latestVersion;
  String? minSupportedVersion;
  bool? forceUpdate;
  String? updateMessage;

  UpdateModel({this.latestVersion, this.minSupportedVersion, this.forceUpdate, this.updateMessage});

  factory UpdateModel.fromJson(Map<String, dynamic> json) => _$UpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateModelToJson(this);

  UpdateEntity toEntity() => UpdateEntity(
        latestVersion: latestVersion,
        minSupportedVersion: minSupportedVersion,
        forceUpdate: forceUpdate,
        updateMessage: updateMessage,
      );
}
