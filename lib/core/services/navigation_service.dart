import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._internal();
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
