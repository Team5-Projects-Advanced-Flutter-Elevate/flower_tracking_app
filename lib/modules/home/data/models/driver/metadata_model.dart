import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;

  MetadataModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) =>
      _$MetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataModelToJson(this);

  Metadata toEntity() => Metadata(
    // Explicitly non-nullable
    currentPage: currentPage,
    totalPages: totalPages,
    totalItems: totalItems,
    limit: limit,
  );
}
