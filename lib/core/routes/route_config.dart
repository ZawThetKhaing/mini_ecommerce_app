import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/pages/login_page.dart';
import 'package:mini_ecommerce_app_assignment/features/auth/presentation/pages/sign_up_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/address_form_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/check_out_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/home_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/payment_form_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/order_successful_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/product_detail.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/search_page.dart';
import 'package:mini_ecommerce_app_assignment/features/others/pages/wrapper.dart';
import 'package:mini_ecommerce_app_assignment/features/others/views/cart_view.dart';
import 'package:mini_ecommerce_app_assignment/features/product/data/models/product_model.dart';

class RouteConfig {
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String wrapper = '/wrapper';
  static const String search = '/search';
  static const String details = '/details';
  static const String cart = '/cart';
  static const String checkOut = '/checkOut';
  static const String paymentForm = '/paymentForm';
  static const String addressForm = '/addressForm';
  static const String orderSuccessful = '/orderSuccessful';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case wrapper:
        return MaterialPageRoute(
          builder: (_) => const WrapperPage(),
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => const SearchPage(),
        );
      case details:
        return MaterialPageRoute(
          builder: (_) => ProductDetail(
            model: settings.arguments as ProductModel,
          ),
        );
      case cart:
        return MaterialPageRoute(
          builder: (_) => CartView(
            isFromDetail: settings.arguments as bool,
          ),
        );
      case checkOut:
        return MaterialPageRoute(
          builder: (_) => const CheckOutPage(),
        );
      case paymentForm:
        return MaterialPageRoute(
          builder: (_) => const PaymentFormPage(),
        );
      case addressForm:
        return MaterialPageRoute(
          builder: (_) => const AddressFormPage(),
        );
      case orderSuccessful:
        return MaterialPageRoute(
          builder: (_) => const OrderSuccessfulPage(),
        );

      default:
        return null;
    }
  }
}
