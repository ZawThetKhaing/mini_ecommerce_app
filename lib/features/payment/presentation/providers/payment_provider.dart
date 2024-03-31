import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mini_ecommerce_app_assignment/core/services/local_notification_service.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/address_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/order_list_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/payment_method_model.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/data/model/purchase_total.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/delete_order_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/get_order_list_usecase.dart';
import 'package:mini_ecommerce_app_assignment/features/payment/domain/usecases/get_order_stream_usecase.dart';
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
    required this.getOrderStream,
    required this.localNotification,
  });

  final SetOrderUsecase setOrderUsecase;
  final GetOrderListUsecase getOrderListUsecase;
  final UpdateOrderUsecase updateOrderUsecase;
  final DeleteOrderUsecase deleteOrderUsecase;
  final GetOrderStreamUsecase getOrderStream;

  final LocalNotification localNotification;

  List<OrderModel>? orderList = [];

  StreamSubscription? getOrderSubScription;

  StreamController<OrderListModel> controller = StreamController.broadcast();

  Future<bool> setOrder({
    required PurchaseTotalModel purchaseTotalModel,
    required List<ProductModel> carItems,
    required bool isCashonDelivery,
    required String uid,
  }) async {
    if (_addressModel == null) return false;
    if (orderList?.isEmpty == true) {
      // orderList = await getOrderList(uid);
    }

    OrderModel orderModel = OrderModel(
      paymentMethod: _paymentMethodModel,
      address: _addressModel!,
      purchaseTotal: purchaseTotalModel,
      cartItems: carItems as List<ProductEntity>,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      arrivialTime: DateTime(DateTime.now().day + 3),
      isDelivered: false,
      isCashOnDelivery: isCashonDelivery,
    );
    if (orderList?.isNotEmpty == true) {
      orderList?.add(orderModel);
    }

    OrderListModel orderListModel = OrderListModel(
      orderList: orderList?.isNotEmpty == true ? orderList! : [orderModel],
    );

    SetOrderParams params =
        SetOrderParams(uid: uid, orderListEntity: orderListModel);

    final result = await setOrderUsecase(params);

    return result.fold((l) => false, (r) {
      getOrderList(uid);
      localNotification.createNotification(
          "Order confirm", "Place order successfully !");
      return true;
    });
  }

  Future<Stream<OrderListModel>?> watchOrder(String uid) async {
    final result = await getOrderStream(uid);

    return result.fold((l) => null, (r) {
      getOrderSubScription = (r as Stream<OrderListModel>?)?.listen((event) {
        orderList = event.orderList as List<OrderModel>?;
        controller.sink.add(event);
      });
      return r as Stream<OrderListModel>?;
    });
  }

  Future<bool> updateorDeleteOrder({
    required String uid,
    OrderModel? orderModel,
    bool isUpdate = false,
  }) async {
    orderList?.remove(orderModel);
    //Remove old orderModel and add updated
    if (isUpdate) {
      orderList?.add(orderModel!);
    }
    final orderListModel = OrderListModel(orderList: orderList ?? []);

    final orderParams =
        SetOrderParams(uid: uid, orderListEntity: orderListModel);

    final result = await updateOrderUsecase(orderParams);

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
      additionalInfo: additionalInfo,
    );
    notifyListeners();
  }

  int orderQuantity(List<ProductModel> cartItems) {
    int total = 0;
    cartItems.forEach((element) {
      total += element.qty!;
    });
    return total;
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

  @override
  void dispose() {
    getOrderSubScription?.cancel();
    super.dispose();
  }
}
