import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shortpal/constant_data.dart';
import 'package:shortpal/home/home_binding.dart';
import 'package:shortpal/home/home_route.dart';

class RouteHelper {
  factory RouteHelper() {
    return _mainRouteHelper;
  }

  RouteHelper._internal();

  static final RouteHelper _mainRouteHelper = RouteHelper._internal();

  List<GetPage> getRoute() => <GetPage>[
        GetPage(
          name: ConstantData.homeRoute,
          page: () => HomeRoute(),
          alignment: Alignment.center,
          transition: Transition.zoom,
          binding: HomeBinding(),
        ),
      ];
}
