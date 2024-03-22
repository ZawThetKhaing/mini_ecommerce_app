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
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: (json['id']).toString(),
        title: json['title'],
        price: (json['price']).toString(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      );

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
        id: entity.id,
        title: entity.title,
        price: entity.price,
        description: entity.description,
        category: entity.category,
        image: entity.image,
        rating: entity.rating,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': (rating as RatingModel).toJson(),
      };
}

class RatingModel extends RatingEntity {
  const RatingModel({
    required super.rate,
    required super.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: (json['rate']).toString(),
        count: (json['count']).toString(),
      );

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}
