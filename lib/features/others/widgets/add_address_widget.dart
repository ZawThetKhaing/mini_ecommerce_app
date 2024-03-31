import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/core/routes/route_config.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/provider/auth_provider.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/address_form_page.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/address_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/presentation/providers/payment_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({
    super.key,
    this.isOrderDetails = false,
    this.orderModel,
  });
  final OrderModel? orderModel;

  final bool isOrderDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Address",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            isOrderDetails
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AddressFormPage(
                            isFromOrderDetail: isOrderDetails,
                            orderModel: orderModel,
                            addressModel: orderModel?.address as AddressModel,
                          ),
                        ),
                      );
                    },
                    icon: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Edit"),
                        SizedBox(
                          width: 8,
                        ),
                        PhosphorIcon(
                          PhosphorIconsRegular.pencil,
                          size: 18,
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        Consumer<PaymentProvider>(
          builder: (_, provider, __) {
            if (provider.addressModel != null || orderModel != null) {
              final model =
                  isOrderDetails ? orderModel?.address : provider.addressModel;

              return GestureDetector(
                onTap: isOrderDetails
                    ? null
                    : () {
                        Navigator.of(context).pushNamed(
                          RouteConfig.addressForm,
                          arguments: model,
                        );
                      },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name : ${model?.fullName}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      isOrderDetails ? const SizedBox() : const Divider(),
                      isOrderDetails
                          ? const SizedBox()
                          : Text(
                              "Phone number : ${model?.phoneNumber}",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                      const Divider(),
                      Text(
                        "Address: ${model?.address}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Divider(),
                      isOrderDetails
                          ? const SizedBox()
                          : model?.additionalInfo != null ||
                                  model!.additionalInfo == ''
                              ? SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Additional Info: ${model?.additionalInfo}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                      model?.additionalInfo == null
                          ? const Divider()
                          : const SizedBox(),
                      Text(
                        "Email: ${context.read<AuthProvider>().user!.email}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteConfig.addressForm);
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PhosphorIcon(
                        PhosphorIconsRegular.plusSquare,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Add new address",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
