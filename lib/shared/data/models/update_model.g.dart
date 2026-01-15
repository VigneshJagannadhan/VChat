// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateModel _$UpdateModelFromJson(Map<String, dynamic> json) => UpdateModel(
  latestVersion: json['latestVersion'] as String?,
  minSupportedVersion: json['minSupportedVersion'] as String?,
  forceUpdate: json['forceUpdate'] as bool?,
  updateMessage: json['updateMessage'] as String?,
);

Map<String, dynamic> _$UpdateModelToJson(UpdateModel instance) =>
    <String, dynamic>{
      'latestVersion': instance.latestVersion,
      'minSupportedVersion': instance.minSupportedVersion,
      'forceUpdate': instance.forceUpdate,
      'updateMessage': instance.updateMessage,
    };
