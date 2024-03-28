import 'package:mini_ecommerce_app_assignment/features/payment/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.fullName,
    required super.phoneNumber,
    required super.address,
    super.additionalInfo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        fullName: json['full_name'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        additionalInfo: json['additionalInfo'],
      );

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'phone_number': phoneNumber,
        'address': address,
        'additionalInfo': additionalInfo,
      };

  AddressModel copyWith(
          {String? fullName,
          String? phoneNumber,
          String? address,
          String? additionalInfo}) =>
      AddressModel(
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        additionalInfo: additionalInfo ?? this.additionalInfo,
      );
}
