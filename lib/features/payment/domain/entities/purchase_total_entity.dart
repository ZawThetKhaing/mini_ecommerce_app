import 'package:equatable/equatable.dart';

class PurchaseTotalEntity extends Equatable {
  const PurchaseTotalEntity(
      {required this.subTotal,
      required this.shippingFee,
      required this.tax,
      required this.total});
  final double subTotal;
  final double shippingFee;
  final double tax;
  final double total;

  @override
  List<Object?> get props => [subTotal, shippingFee, tax, total];
}
