import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';

class ProductResponseModel extends ProductResponseEntity {
  const ProductResponseModel({required super.products});

  factory ProductResponseModel.fromJson(List<dynamic> list) {
    return ProductResponseModel(
      products: list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rate,
    required super.count,
    super.qty,
    super.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: (json['id']).toString(),
        title: json['title'],
        price: (json['price']).toString(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rate: (json['rating']['rate']).toString(),
        count: (json['rating']['count']).toString(),
        qty: json['qty'] ?? 1,
        createdAt: json['created_at'] == null
            ? null
            : (json['created_at'] as firestore.Timestamp).toDate(),
      );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        category: entity.category,
        image: entity.image,
        rate: entity.rate,
        count: entity.count,
        qty: entity.qty,
        createdAt: entity.createdAt,
      );

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rate: rate,
        count: count,
        qty: qty,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': {
          'rate': rate,
          'count': count,
        },
        'qty': qty,
        'created_at': createdAt,
      };

  ProductModel copyWith({
    String? id,
    String? title,
    String? price,
    String? description,
    String? category,
    String? image,
    String? rate,
    String? count,
    int? qty,
    DateTime? createdAt,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        count: count ?? this.count,
        qty: qty ?? this.qty,
        createdAt: createdAt ?? this.createdAt,
      );
}
