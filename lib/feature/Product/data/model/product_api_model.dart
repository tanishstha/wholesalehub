import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wholesalehub_app/feature/Product/domain/entity/product_entity.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? productId;
  final String productName;
  final String? image;
  final String description;
  final String type;
  final String quantity;
  final String price;

  const ProductApiModel({
    this.productId,
    required this.productName,
    required this.description,
    required this.image,
    required this.type,
    required this.quantity,
    required this.price,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) {
    try {
      json.remove("__v");
      // print("PRODUCTSSS:: $json");
      // print("productId Type: ${json['_id']?.runtimeType}");
      // print("productId type: ${json['_id']?.runtimeType}");
      // print("productName type: ${json['productName']?.runtimeType}");
      // print("image type: ${json['image']?.runtimeType}");
      // print("description type: ${json['description']?.runtimeType}");
      // print("type type: ${json['type']?.runtimeType}");
      // print("quantity type: ${json['quantity']?.runtimeType}");
      // print("price type: ${json['price']?.runtimeType}");
      return ProductApiModel(
          productId: json['_id']?.toString() ?? '',
          productName: json['productName']?.toString() ?? '',
          image: json['image']?.toString() ?? '',
          description: json['description']?.toString() ?? '',
          type: json['type']?.toString() ?? '',
          quantity: json['quantity'].toString() ?? '',
          price: json['price'].toString() ?? '');
    } catch (e) {
      print("Error parsing ProductApiModel: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // To Entity
  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      productName: productName,
      description: description,
      type: type,
      quantity: quantity,
      price: price,
      image: image ?? '',
    );
  }

  // From Entity
  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      productId: entity.productId,
      productName: entity.productName,
      description: entity.description,
      type: entity.type,
      quantity: entity.quantity,
      price: entity.price,
      image: entity.image,
    );
  }

  // Convert Api List  to entity list
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props =>
      [productId, productName, image, description, type, quantity, price];
}
