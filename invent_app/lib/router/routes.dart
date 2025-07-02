

import 'package:invent_app/pages/categories.page.dart';
import 'package:invent_app/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:invent_app/pages/login.page.dart';
import 'package:invent_app/pages/movement.page.dart';
import 'package:invent_app/pages/products.page.dart';
import 'package:invent_app/pages/register.page.dart';
import 'package:invent_app/pages/reports.page.dart';
import 'package:invent_app/pages/supplier.page.dart';
import 'package:invent_app/pages/warehouse.page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    HomePag.routeName: (BuildContext context) => const HomePag(),
    LoginPage.routeName: (BuildContext context) => const LoginPage(),
    ProductPage.routeName: (BuildContext context) => const ProductPage(),
    MovementsPage.routeName: (BuildContext context) => const MovementsPage(),
    RegisterPage.routeName: (BuildContext context) => const RegisterPage(),
    SupplierPage.routeName: (BuildContext context) => const SupplierPage(),
    WareHousePage.routeName: (BuildContext context) => const WareHousePage(),
    CategoriesPage.routeName: (BuildContext context) => const CategoriesPage(),
    ReportsPage.routeName: (BuildContext context) => const ReportsPage(),

  };
}
