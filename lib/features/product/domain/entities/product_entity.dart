import 'package:equatable/equatable.dart';

class ProductResponseEntity extends Equatable {
  const ProductResponseEntity({required this.products});

  final List<ProductEntity> products;

  @override
  List<Object?> get props => [products];
}

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final String id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;
  final RatingEntity rating;

  @override
  List<Object?> get props => [];
}

class RatingEntity {
  const RatingEntity({
    required this.rate,
    required this.count,
  });

  final String rate;
  final String count;
}
