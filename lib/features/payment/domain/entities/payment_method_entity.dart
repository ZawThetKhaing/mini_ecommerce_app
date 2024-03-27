import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  const PaymentMethodEntity(
      {required this.name,
      required this.cardNumber,
      required this.expiredDate,
      required this.cvv});

  final String name;
  final String cardNumber;
  final String expiredDate;
  final String cvv;

  @override
  List<Object?> get props => [name, cardNumber, expiredDate, cvv];
}
