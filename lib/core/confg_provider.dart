
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:swaply/services/firestore_service.dart';

import 'package:swaply/services/auth-service.dart';
class ConfigureProviders{
  final List<SingleChildWidget> providers;
  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {
    final authService = AuthService();
    final firestoreService = FirestoreService();

    return ConfigureProviders(providers: [
      Provider<AuthService>.value(value: authService),
      Provider<FirestoreService>.value(value: firestoreService)
    ]);
  }

}