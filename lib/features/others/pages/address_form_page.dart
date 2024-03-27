import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/custom_text_field.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:provider/provider.dart';

class AddressFormPage extends StatefulWidget {
  const AddressFormPage({super.key});

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _additionalInfoFocus = FocusNode();

  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  late final PaymentProvider paymentProvider;

  @override
  void initState() {
    paymentProvider = context.read<PaymentProvider>();
    _nameController.text = paymentProvider.addressModel?.fullName ?? "";
    _phoneController.text = paymentProvider.addressModel?.phoneNumber ?? "";
    _addressController.text = paymentProvider.addressModel?.address ?? "";
    _additionalInfoController.text =
        paymentProvider.addressModel?.additionalInfo ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _additionalInfoController.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    _additionalInfoFocus.dispose();
    fromKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add New Address",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: fromKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Input full name',
                  onEditingComplete: _phoneFocus.requestFocus,
                ),
                CustomTextField(
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  hintText: "Input mobile number",
                  keyboardType: TextInputType.phone,
                  onEditingComplete: _addressFocus.requestFocus,
                ),
                CustomTextField(
                  controller: _addressController,
                  focusNode: _addressFocus,
                  hintText: 'House no./building/street/area',
                  onEditingComplete: _additionalInfoFocus.requestFocus,
                ),
                CustomTextField(
                  maxLine: 4,
                  controller: _additionalInfoController,
                  focusNode: _additionalInfoFocus,
                  hintText: 'Add additional information (optional)',
                  validator: (value) => null,
                  onEditingComplete: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (fromKey.currentState?.validate() != true) return;
                    context.read<PaymentProvider>().storeAddress(
                          fullName: _nameController.text,
                          phoneNumber: _phoneController.text,
                          address: _addressController.text,
                          additionalInfo: _additionalInfoController.text,
                        );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Address save successfully"),
                      ),
                    );
                  },
                  child: const Text("Save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
