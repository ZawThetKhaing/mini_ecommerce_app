import 'package:flutter/cupertino.dart';
import 'package:mini_ecommerce_app_assignment/core/services/local_notification_service.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/address_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_list_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/payment_method_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/purchase_total.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/delete_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/get_order_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/set_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/update_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';
import 'package:mini_ecommerce_app_assignment/features/product/domain/entities/product_entity.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentProvider({
    required this.setOrderUsecase,
    required this.getOrderListUsecase,
    required this.updateOrderUsecase,
    required this.deleteOrderUsecase,
    required this.localNotification,
  });

  final SetOrderUsecase setOrderUsecase;
  final GetOrderListUsecase getOrderListUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  final DeleteOrderUsecase deleteOrderUsecase;

  final LocalNotification localNotification;

  List<OrderModel> orderList = [];

  Future<bool> setOrder({
    required PurchaseTotalModel purchaseTotalModel,
    required List<ProductModel> carItems,
    required bool isCashonDelivery,
    required String uid,
  }) async {
    if (_addressModel == null) return false;

    OrderModel orderModel = OrderModel(
      paymentMethod: _paymentMethodModel,
      purchaseTotal: purchaseTotalModel,
      cartItems: carItems as List<ProductEntity>,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      arrivialTime: DateTime(DateTime.now().day + 3),
      isDelivered: false,
      isCashOnDelivery: isCashonDelivery,
    );

    OrderListModel orderListModel =
        OrderListModel(address: _addressModel!, orderList: [orderModel]);

    SetOrderParams params =
        SetOrderParams(uid: uid, orderListEntity: orderListModel);

    final result = await setOrderUsecase(params);

    return result.fold((l) => false, (r) {
      localNotification.createNotification(
          "Order confirm", "Place order successfully !");
      return true;
    });
  }

  Future<bool> updateOrder({required SetOrderParams orderParams}) async {
    // if (orderList.contains(orderParams.orderEntity)) {
    //   orderList.remove(orderParams.orderEntity);
    // }
    final result = await updateOrderUsecase(orderParams);

    return result.fold((l) => false, (r) {
      return true;
    });
  }

  Future<bool> deleteOrder({required String orderId}) async {
    final result = await deleteOrderUsecase(orderId);

    return result.fold((l) => false, (r) {
      return true;
    });
  }

  Future<List<OrderModel>?> getOrderList(String uid) async {
    final result = await getOrderListUsecase(uid);
    return result.fold((l) => null, (r) {
      orderList = r as List<OrderModel>;
      return orderList;
    });
  }

  AddressModel? _addressModel;

  AddressModel? get addressModel => _addressModel;

  PaymentMethodModel? _paymentMethodModel;

  PaymentMethodModel? get paymentMethodModel => _paymentMethodModel;

  String? cardExpiredDate;

  void storeCardExpiredDate(String value) {
    cardExpiredDate = value;
    notifyListeners();
  }

  void storeAddress({
    required String fullName,
    required String phoneNumber,
    required String address,
    String? additionalInfo,
  }) {
    _addressModel = AddressModel(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
    );
    notifyListeners();
  }

  void storePayment({
    required String name,
    required String cardNumber,
    required String expiredDate,
    required String cvv,
  }) {
    _paymentMethodModel = PaymentMethodModel(
      name: name,
      cardNumber: cardNumber,
      expiredDate: expiredDate,
      cvv: cvv,
    );
    notifyListeners();
  }
}
