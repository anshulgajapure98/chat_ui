import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_listing_model.freezed.dart';
part 'product_listing_model.g.dart';

@freezed
abstract class ProductListingModel with _$ProductListingModel {
  const factory ProductListingModel({
    List<Products>? products,
    int? total,
    int? skip,
    int? limit,
  }) = _ProductListingModel;

  factory ProductListingModel.fromJson(Map<String, Object?> json) =>
      _$ProductListingModelFromJson(json);
}

@freezed
abstract class Products with _$Products {
  const factory Products({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    int? weight,
    Dimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<Reviews>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    Meta? meta,
    List<String>? images,
    String? thumbnail,
  }) = _Products;

  factory Products.fromJson(Map<String, Object?> json) =>
      _$ProductsFromJson(json);
}

@freezed
abstract class Dimensions with _$Dimensions {
  const factory Dimensions({double? width, double? height, double? depth}) =
      _Dimensions;

  factory Dimensions.fromJson(Map<String, Object?> json) =>
      _$DimensionsFromJson(json);
}

@freezed
abstract class Reviews with _$Reviews {
  const factory Reviews({
    int? rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  }) = _Reviews;

  factory Reviews.fromJson(Map<String, Object?> json) =>
      _$ReviewsFromJson(json);
}

@freezed
abstract class Meta with _$Meta {
  const factory Meta({
    String? createdAt,
    String? updatedAt,
    String? barcode,
    String? qrCode,
  }) = _Meta;

  factory Meta.fromJson(Map<String, Object?> json) => _$MetaFromJson(json);
}
