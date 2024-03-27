import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_ecommerce_app_assignment/features/others/widgets/custom_text_field.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:provider/provider.dart';

class PaymentFormPage extends StatefulWidget {
  const PaymentFormPage({super.key});

  @override
  State<PaymentFormPage> createState() => _PaymentFormPageState();
}

class _PaymentFormPageState extends State<PaymentFormPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cvvController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "Check out",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 320,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    padding: const EdgeInsets.only(left: 16),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Text(
                      "Payment method",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 1,
                    right: 15,
                    child: Image.asset('assert/master_card.png'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Card number",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomTextField(
                    controller: _cardNumberController,
                    hintText: "Input card number",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Expired Date",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer<PaymentProvider>(
                    builder: (_, provider, __) => GestureDetector(
                      onTap: () async {
                        final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime(DateTime.now().year + 5),
                          initialDate: DateTime.now(),
                        );
                        if (result != null) {
                          provider.storeCardExpiredDate(
                              DateFormat.yMMMMd().format(result));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                              Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          provider.cardExpiredDate == null
                              ? "MM/YY"
                              : provider.cardExpiredDate!,
                          style:
                              Theme.of(context).inputDecorationTheme.hintStyle,
                        ),
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _cvvController,
                    hintText: "CVV",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        final provider = context.read<PaymentProvider>();
                        if (provider.cardExpiredDate == null ||
                            formKey.currentState?.validate() != true) return;
                        provider.storePayment(
                          name: _cardNumberController.text,
                          cardNumber: _cardNumberController.text,
                          cvv: _cvvController.text,
                          expiredDate: provider.cardExpiredDate!,
                        );

                        Navigator.of(context).pop();
                      },
                      child: const Text("Proceed to buy"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
