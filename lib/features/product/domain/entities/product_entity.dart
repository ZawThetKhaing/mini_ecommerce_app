import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductResponseEntity extends Equatable {
  const ProductResponseEntity({required this.products});

  @HiveField(0)
  final List<ProductEntity> products;

  @override
  List<Object?> get props => [products];
}

@HiveType(typeId: 1)
class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,
    this.qty,
    this.createdAt,
  });
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final String rate;

  @HiveField(7)
  final String count;

  @HiveField(8)
  final int? qty;

  @HiveField(9)
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
      ];
}
