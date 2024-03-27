import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  const AddressEntity(
      {required this.fullName,
      required this.phoneNumber,
      required this.address,
      required this.additionalInfo});
  final String fullName;
  final String phoneNumber;
  final String address;
  final String? additionalInfo;

  @override
  List<Object?> get props => [fullName, phoneNumber, address, additionalInfo];
}
