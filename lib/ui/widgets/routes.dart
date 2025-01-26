// routes.dart
import 'package:flutter/material.dart';
import 'package:swaply/ui/pages/home_pege.dart';
import 'package:swaply/ui/widgets/item_card_user.dart';
import 'package:swaply/ui/widgets/item_form.dart';
import 'package:swaply/ui/widgets/list_anuncio_user.dart';
import 'package:swaply/ui/widgets/login_or_register_page.dart';


class ConfigRoutes {
  static const String home = '/';
  static const String registerPagORLogin = '/LoginOrRegisterPage';
  static const String itemForm = '/ItemForm';
  static const String listAnuncioUser = '/ListAnuncioUser';

  static Map<String, WidgetBuilder> get routes {
    return {
      home:               (context) => const HomePage(),  // Rota para a página inicial
      registerPagORLogin: (context) => const LoginOrRegisterPage(),  // Rota para a página de login
      itemForm :          (context) => const ItemForm(),
      listAnuncioUser:    (context) => const ListAnuncioUser(),
    };
  }
}
