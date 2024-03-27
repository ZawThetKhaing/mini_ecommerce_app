import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends PaymentMethodEntity {
  const PaymentMethodModel({
    required super.name,
    required super.cardNumber,
    required super.expiredDate,
    required super.cvv,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        name: json['name'],
        cardNumber: json['card_number'],
        expiredDate: json['expired_date'],
        cvv: json['cvv'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'card_number': cardNumber,
        'expired_date': expiredDate,
        'cvv': cvv,
      };
}
